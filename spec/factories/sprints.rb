# frozen_string_literal: true

FactoryBot.define do

  factory :sprint do
    title { Faker::Hacker.say_something_smart }
    duration { 4.weeks }

    trait :annotated do
      description { Faker::Hipster.sentence }
      goal { Faker::Hacker.ingverb }
    end

    trait :started do
      started_at { Faker::Date.between(3.days.ago, Time.zone.today) }
    end

    trait :with_backlog_items do
      transient do
        item_count { 3 }
      end

      after(:create) do |s, evaluator|
        s.sprint_backlog_items = create_list :sprint_backlog_item, evaluator.item_count
      end
    end
  end

end
