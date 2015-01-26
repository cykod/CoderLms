class UserPage < ActiveRecord::Base
  include PermalinkSupport
  belongs_to :page
  belongs_to :user

  has_many :user_page_files

  accepts_nested_attributes_for :user_page_files

  has_permalink -> { UserPage.where(page: self.page) }


  def page_files_attributes=(val)
    user_files = self.user_page_files.index_by(&:page_file_id)

    val.each do |page_file|
      user_file = user_files[page_file[:id].to_i] || user_page_files.build(page_file_id: page_file[:id].to_i)
      user_file.body = page_file[:body]
      user_file.save
    end
  end

  def self.fetch(page, user)
    find_or_create_by(page: page, user: user)
  end

  def page_files
    if user.admin?
      self.page.page_files
    else
      user_files = user_page_files.index_by(&:page_file_id)
      self.page.page_files.map do |page_file|
        page_file.override_user_page_file(user_files[page_file.id])
        page_file
      end
    end
  end

  def page_file(name)
    page_file = page.page_files.where(name: name).first
    user_file = user_page_files.where(page_file_id: page_file.id).first
    page_file.override_user_page_file(user_file)
    page_file
  end

  def name_changed?
    self.new_record?
  end

  protected

  def permalink_string
    SecureRandom.urlsafe_base64.downcase[0..5]
  end
    
end
