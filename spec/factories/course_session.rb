FactoryGirl.define do
  factory :course_session do
    sequence(:name) { |n| "Course Session #{n}" }
    course
    open true
    code "123456"
  end
end
