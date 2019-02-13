# frozen_string_literal: true

FactoryBot.define do

  factory :sprint_backlog_item do
    sprint
    backlog_item
    team
    sequence(:position, 0)
  end

end
