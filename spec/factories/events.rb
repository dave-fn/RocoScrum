# frozen_string_literal: true

FactoryBot.define do

  factory :event do
    name { Faker::Ancient.titan }
    timebox { Faker::Number.number(3) }
    initialize_with { Event.find_or_create_by(name: name) }

    trait :sprint do
      name { 'Sprint' }
      timebox { 1.month }
    end

    trait :sprint_planning do
      name { 'Sprint Planning' }
      timebox { 8.hours }
    end

    trait :sprint_review do
      name { 'Sprint Review' }
      timebox { 4.hours }
    end

    trait :sprint_retrospective do
      name { 'Sprint Retrospective' }
      timebox { 3.hours }
    end

    trait :daily_scrum do
      name { 'Daily Scrum' }
      timebox { 15.minutes }
    end

    factory :sprint_event, traits: [:sprint]
    factory :sprint_planning_event, traits: [:sprint_planning]
    factory :sprint_review_event, traits: [:sprint_review]
    factory :sprint_retrospective_event, traits: [:sprint_retrospective]
    factory :daily_scrum_event, traits: [:daily_scrum]
  end

end
