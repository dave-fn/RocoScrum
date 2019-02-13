# frozen_string_literal: true

FactoryBot.define do

  factory :backlog_item do
    # transient do
    #   ready_ratio { 0.3 }
    # end

    title { Faker::Hacker.say_something_smart }

    # after(:build) do |item, evaluator|
    #   item.ready = Faker::Boolean.boolean(evaluator.ready_ratio)
    # end

    trait :annotated do
      requirement { Faker::Finance.vat_number }
      description { Faker::Hipster.sentence }
    end
  end

end
