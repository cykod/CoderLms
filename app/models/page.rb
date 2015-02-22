class Page < ActiveRecord::Base
  belongs_to :lesson
  has_many :page_files, -> { order("position ASC") }

  accepts_nested_attributes_for :page_files

  acts_as_list scope: :lesson

  validates :page_type, presence: true
  validates :name, presence: true

  @@page_types = [ "editor", "slide", "quiz" ]

  @@quiz_states = [ "unstarted", "started", "open" ]

  def quiz?; self.page_type == "quiz"; end
  def slide?; self.page_type == "slide"; end

  def editor?; self.page_type == "editor"; end

  def quiz_started?; self.quiz_state == "started" || self.quiz_state == "open"; end
  def quiz_results?; self.quiz_state == "open"; end

  def self.page_types 
    @@page_types
  end

  def self.quiz_states
    @@quiz_states
  end
  
end
