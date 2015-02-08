class UserPageFile < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_page
  belongs_to :page_file


  before_create :assign_to_user
  before_save :render_body_html
  before_save :set_correct

  protected

  def assign_to_user
    self.user = self.user_page.user
  end

  def render_body_html
    self.body_html = Renderer.render(self.page_file.page.page_type,self.page_file.extension, self.body)
  end

  def set_correct
    if self.user_page.page.quiz?
      self.correct = self.page_file.correct_answer?(self.body)
    else
      self.correct = nil
    end
    true
  end

end
