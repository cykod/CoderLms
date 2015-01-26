FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:name) { |n| "Svend User#{n}" }
    sequence(:username) { |n| "user#{n}" }
    sequence(:uid) { |n| "uid#{n}" }
    admin false
  end
end
