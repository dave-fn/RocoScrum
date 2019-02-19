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

      after :create do |prod, evaluator|
        evaluator.item_count.times do
          create :product_backlog_item, product: prod
        end
      end
    end
  end

end
