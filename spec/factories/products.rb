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
  end

end
