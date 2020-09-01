# frozen_string_literal: true

FactoryBot.define do

  factory :sbi_status_update do
    sprint_backlog_item
    item_status
    developer
    association :creator, factory: [:user, :scrum_master_name]
  end

end
