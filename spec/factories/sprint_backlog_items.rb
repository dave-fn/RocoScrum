FactoryBot.define do
  factory :sprint_backlog_item do
    sprint { nil }
    backlog_item { nil }
    team { nil }
    position { 1 }
  end
end
