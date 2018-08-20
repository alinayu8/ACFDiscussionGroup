FactoryBot.define do
  factory :user do
    password_digest "MyString"
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    role "MyString"
    active false
  end
    factory :largeGroup do
        date Date.current
        session_number 1
        semester "f18"
    end

    factory :discussionGroup do
        association :largeGroup
        name "Alina Yu"
    end

    factory :memberDg do
        association :discussionGroup
        association :member
        attended true
    end

    factory :member do
        association :cellGroup
        name "Alina Yu"
        gender "Female"
        is_active true
        is_leader true
        year 4
    end

    factory :cellGroup do
        name "Kindle"
        gender "Female"
    end
end