# frozen_string_literal: true

FactoryBot.define do

  factory :project do
    title { Faker::Device.model_name }
    association :admin, factory: [:user, :project_admin_name]

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end
  end

end
