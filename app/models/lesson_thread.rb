class LessonThread < ActiveRecord::Base

  belongs_to :user
  belongs_to :course_session
  belongs_to :lesson

  scope :for_lesson, -> (lesson) { where(lesson_id: lesson.id) }
  scope :published, -> { where(published: true) }

  before_save :set_body

  protected

  def set_body
    self.body_html = Kramdown::Document.new(self.body).to_html
  end
                         
end
