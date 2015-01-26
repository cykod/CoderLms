class CourseSession < ActiveRecord::Base

  belongs_to :course

  has_many :user_course_sessions
  has_many :users, through: :user_course_sessions

  attr_reader :user

  include PermalinkSupport
  has_permalink -> { CourseSession }

  def self.for_user(user, permalink)
    course_session = fetch(permalink)
    return nil unless course_session

    course_session.for_user(user)
  end

  def self.fetch(permalink)
    self.where(permalink: permalink).first
  end

  def for_user(user)
    @user = user
    access? ? self : nil
  end

  def access?
    user.admin?  || self.users.where(id: user.id).present?
  end

  def admin?
    user && user.admin?
  end

  def to_param
    self.permalink
  end

  def lessons
    scope = self.course.lessons.by_latest
    scope = scope.visible if !admin?
    scope
  end

  def lesson(position)
    lessons.where(position: position).first
  end
end
