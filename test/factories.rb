FactoryBot.define do
    factory :largeGroup do
      association :discussionGroup
      date Date.current
      session_number 1
      semester "Fall 2018"
    end

    factory :discussionGroup do
        association :largeGroup
        association :memberDgs
        name "Alina Yu"
    end

    factory :memberDgs do
        association :discussionGroup
        association :member
        attended true
    end

    factory :member do
        association :memberDgs
        association :cellGroup
        name "Alina Yu"
        gender "female"
        is_leader true
    end

    factory :cellGroup do
        association :member
        name "Kindle"
        gender "female"
    end
end