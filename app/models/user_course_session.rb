class UserCourseSession < ActiveRecord::Base
  belongs_to :course_session
  belongs_to :course
  belongs_to :user

  before_save :set_course

  attr_accessor :code

  protected

  def set_course
    self.course = self.course_session.course
    true
  end
end
