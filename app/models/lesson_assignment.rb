class LessonAssignment < ActiveRecord::Base
  belongs_to :lesson

  before_save :save_body_html

  has_many :user_assignments

  def name 
    "#{self.lesson.name} #{self.body}"
  end

  def save_body_html
    self.body_html = Kramdown::Document.new(self.body).to_html.gsub(/^\<p\>(.*)\<\/p\>/,"\\1")
  end

  def for_user(user,all_homeworks=nil) 
    if all_homeworks
      all_homeworks[self.id] || self.user_assignments.build(
        user_id: user.id
      )
    else
      UserAssignment.where(user_id: user.id, lesson_assignment: self.id).first || self.user_assignments.build(
        user_id: user.id
      )
    end
  end
end
