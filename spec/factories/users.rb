# frozen_string_literal: true

FactoryBot.define do

  factory :user, aliases: [:member] do

    sequence(:name) { |n| "regular-user-#{n}" }
    email { "#{name}@example.org" }
    password { name }

    trait :sequenced_fields do
      transient do
        base_name { 'user_id' }
      end

      sequence(:name) { |n| "#{base_name}-#{n}" }
    end

    trait :random_fields do
      name { Faker::Internet.username(8..15) }
      email { Faker::Internet.safe_email }
      password { Faker::Internet.password }
    end

    trait :as_admin do
      after(:create) do |u, _evaluator|
        create :admin, user: u
      end
    end

    trait :scrum_master_name do
      sequence(:name) { |n| "scrum-master-#{n}" }
    end

    trait :developer_name do
      sequence(:name) { |n| "developer-#{n}" }
    end

    trait :project_admin_name do
      sequence(:name) { |n| "project-admin-#{n}" }
    end

    trait :product_owner_name do
      sequence(:name) { |n| "product-owner-#{n}" }
    end

    factory :admin_user, traits: [:as_admin]

  end

end
