# frozen_string_literal: true

FactoryBot.define do

  factory :sprint_backlog_item do
    sprint
    backlog_item
    sequence(:position, 0)

    trait :with_team do
      team
    end
  end

end
