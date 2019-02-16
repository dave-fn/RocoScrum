# frozen_string_literal: true

FactoryBot.define do

  factory :project_sprint do
    project
    sprint
    sequence(:position, 0)
  end

end
