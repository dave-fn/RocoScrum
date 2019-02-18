# frozen_string_literal: true

FactoryBot.define do

  factory :project do
    title { Faker::Device.model_name }
    association :admin, factory: [:user, :project_admin_name]

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end

    trait :with_sprints do
      transient do
        sprint_count { 3 }
      end

      after(:create) do |proj, evaluator|
        evaluator.sprint_count.times do
          create :project_sprint, project: proj, sprint: (create :sprint, :with_backlog_items, item_count: 4)
        end
      end
    end
  end

end
