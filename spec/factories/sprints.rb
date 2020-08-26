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
      started_at { Faker::Date.between(from: 3.days.ago, to: Time.zone.today) }
    end

    trait :with_backlog_items do
      transient do
        item_count { 3 }
        team { nil }
      end

      after :create do |s, evaluator|
        evaluator.item_count.times do
          if evaluator.team.nil?
            create :sprint_backlog_item, sprint: s
          else
            create :sprint_backlog_item, sprint: s, team: evaluator.team
          end
        end
      end
    end
  end

end
