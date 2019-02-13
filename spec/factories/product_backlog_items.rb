FactoryBot.define do
  factory :product_backlog_item do
    product { nil }
    backlog_item { nil }
    position { 1 }
  end
end
