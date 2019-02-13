# frozen_string_literal: true

FactoryBot.define do

  factory :product_backlog_item do
    product
    backlog_item
    sequence(:position, 0)
  end

end
