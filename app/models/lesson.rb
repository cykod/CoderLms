class Lesson < ActiveRecord::Base
  include PermalinkSupport

  belongs_to :course
  has_many :pages, -> { order("position") }
  has_many :lesson_assignments

  has_many :lesson_threads

  validates :course, presence: true

  acts_as_list scope: :course
  has_permalink -> { Lesson.where(course_id: self.course_id) }

  scope :visible, -> { where("visible_starting <= ?",Time.zone.now.to_date) }
  scope :by_latest, -> { order("position DESC") }

  before_save :set_body

  def page(position)
    self.pages.where(position: position).first
  end

  def add_page!(options)
    self.pages.create(options)
  end

  protected

  def set_body
    self.body_html = Kramdown::Document.new(self.body).to_html
  end


end
