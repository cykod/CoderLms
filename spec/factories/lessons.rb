# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    sequence(:name) { |n| "Lesson #{n}" }
    course
  end
end
