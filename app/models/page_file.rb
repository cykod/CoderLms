class PageFile < ActiveRecord::Base

  belongs_to :page
  belongs_to :lesson

  before_create :set_meta
  before_save :set_body_html

  acts_as_list scope: :page

  @@modes = { 
    "html" => "html", 
    "js" => "javascript", 
    "css" => "css",
    "md" => "markdown",
    "json" => "json"
  }

  @@display_modes = %w(html markdown text)

  def mode
    @@modes[self.extension] || "text"
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

  def body_html_resolved
    @user_page_file && @user_page_file.body_html.present? ? @user_page_file.body_html : self.body_html
  end

  protected

  def set_meta
    self.lesson_id = self.page.lesson_id
    self.extension = self.name.split(".")[-1].downcase
    true
  end

  def set_body_html
    self.body_html = self.body
    true
  end

end
