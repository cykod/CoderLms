class Course < ActiveRecord::Base
  has_many :lessons, -> { order("position ASC") }

end
