# frozen_string_literal: true

FactoryBot.define do

  factory :product do
    title { Faker::Device.model_name }
    project

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end

    trait :with_product_owner do
      association :owner, factory: [:user, :product_owner_name]
    end

    trait :with_backlog_items do
      transient do
        item_count { 3 }
      end

      after(:create) do |prod, evaluator|
        prod.product_backlog_items = create_list :product_backlog_item, evaluator.item_count
      end
    end
  end

end
