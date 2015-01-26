class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson_assignment

  validates_presence_of :user
  validates_presence_of :lesson_assignment

  validate :check_url

  serialize :validation_errors

  before_save :html5_validate_url
  before_create :check_is_late

  has_attached_file :file, :styles =>  { :thumb => "128x128#" }

  def check_url
    if self.lesson_assignment && self.lesson_assignment.requires_url? && self.url.blank?
      errors.add(:url,'is missing')
    elsif self.url.present?
      errors.add(:url,'is invalid') unless valid_url(self.url)
    end
  end

  def valid_url(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end

  def html5_validate_url
    self.validation_errors = []
    if self.url.present?
      @validator = Html5Validator::Validator.new

      @validator.validate_uri(self.url)

      if !@validator.valid?
        self.validation_errors = @validator.errors
      end
    end
  end

  def check_is_late
    if self.lesson_assignment.lesson.due_date.present? &&
      Time.now > self.lesson_assignment.lesson.due_date
      self.late = true
    end
  end

end
