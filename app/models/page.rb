class Page < ActiveRecord::Base
  belongs_to :lesson
  has_many :page_files, -> { order("position ASC") }

  accepts_nested_attributes_for :page_files

  acts_as_list scope: :lesson

  @@page_types = [ "editor", "slide", "quiz" ]

  def self.page_types 
    @@page_types
  end
end
