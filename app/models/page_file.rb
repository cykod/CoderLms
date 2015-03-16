class PageFile < ActiveRecord::Base

  belongs_to :page
  belongs_to :lesson


  before_validation :set_name_and_properties, on: :create

  before_create :set_meta
  before_save :set_body_html
  before_save :set_question_and_answers


  attr_accessor :file_type

  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /\A.*\Z/

  acts_as_list scope: :page

  @@modes = { 
    "html" => "html", 
    "js" => "javascript", 
    "css" => "css",
    "md" => "markdown",
    "json" => "json",
    "txt" => "text",
    "text" => "text"
  }

  @@display_modes = %w(html markdown text)

  def mode
    @@modes[self.extension] || "unknown"
  end

  def resolved_extension
    if self.extension == "md"
      "html"
    else
      self.extension
    end
  end

  def binary?
    self.body.blank? && self.file?
  end

  def displayable
    @@display_modes.include?(self.mode)
  end

  def override_user_page_file(user_page_file)
    @user_page_file = user_page_file
  end

  def user_page_file_id
    @user_page_file && @user_page_file.id
  end

  def body_resolved
    @user_page_file && @user_page_file.body.present? ? @user_page_file.body : self.body
  end

  def correct?
    @user_page_file && @user_page_file.correct?
  end

  def body_html_resolved
    @user_page_file && @user_page_file.body_html.present? ? @user_page_file.body_html : self.body_html
  end

  def correct_answer?(answer)
    (self.answers||[])[0] == answer
  end

  protected

  def set_meta
    self.lesson_id = self.page.lesson_id
    self.extension = self.name.split(".")[-1].downcase
    true
  end

  def set_body_html
    self.body_html = Renderer.render(self.page.page_type, self.extension, self.body.to_s)
    true
  end

  def set_question_and_answers
    doc = Nokogiri::HTML.fragment(self.body_html)
    return true unless self.page.quiz? && doc.css("ul:last-child").first
    self.answers = []
    doc.css("ul:last-child").first.children.each do |child|
      if child.name == "li"
        self.answers.push(child.children.to_html)
      end
    end

    doc.css("ul:last-child").remove
    self.question = doc.to_html
    
    true
  end

  def set_name_and_properties
    if file_file_name.present?
      set_base_properties

      if self.file_type == "text"
        set_text_properties
      end
    elsif name.present?
      self.file_content_type = PageFile.type_for_name(self.name)
      set_base_properties
    end
  end


  
  @@mime_overrides = {
    "application/json" => "text",
    "application/xml" => "text",
    "application/javascript" => "text"
  }

  @@type_overrides = {
    "md" => "text/x-markdown",
    "tmx" => "text/xml"
  }

  def self.type_for_name(name)
    extension = name.split(".")[-1].to_s.downcase
    @@type_overrides[extension] || 
      Mime::Type.lookup_by_extension(extension).to_s
  end



  def set_base_properties
    self.name = self.file_file_name if self.file_file_name.present?

    if self.file_content_type = "application/octet/stream"
      self.file_content_type = PageFile.type_for_name(self.name)
    end

    if @@mime_overrides[self.file_content_type]
      self.file_type =  @@mime_overrides[self.file_content_type]
    else 
      self.file_type = self.file_content_type.split("/")[0]
    end
  end

  def set_text_properties
    txt = File.open(file.queued_for_write[:original].path).read
    self.file_content_type = PageFile.type_for_name(self.name)
    self.body = txt
    file.clear
  end

end
