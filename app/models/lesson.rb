class Lesson < ActiveRecord::Base
  include PermalinkSupport

  belongs_to :course
  has_many :pages, -> { order("position") }

  validates :course, presence: true

  acts_as_list scope: :course
  has_permalink -> { Lesson.where(course_id: self.course_id) }

  scope :visible, -> { where("visible_starting >= ?",Time.zone.now.to_date) }
  scope :by_latest, -> { order("position DESC") }

  def page(position)
    self.pages.where(position: position).first
  end

  def add_page!
    self.pages.create
  end

  protected



end
