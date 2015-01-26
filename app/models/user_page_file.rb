class UserPageFile < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_page
  belongs_to :page_file


  before_create :assign_to_user
  before_save :render_body_html

  protected

  def assign_to_user
    self.user = self.user_page.user
  end

  def render_body_html
    self.body_html = self.body
  end


end
