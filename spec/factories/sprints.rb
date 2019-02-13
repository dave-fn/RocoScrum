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
  end

end
