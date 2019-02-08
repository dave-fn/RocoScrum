FactoryBot.define do

  factory :user, aliases: [:member, :product_owner] do
    name { Faker::Internet.username(8..15) }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }

    trait :matching_fields do
      email { Faker::Internet.safe_email(name) }
      password { name }
    end

    trait :sequenced_fields do
      transient do
        base_name { 'user_id' }
      end

      sequence(:name) { |n| "#{base_name}_#{n} "}
    end

    trait :as_admin do
      after(:create) do |u, evaluator|
        create :admin, user: u
      end
    end

    factory :dummy_user, traits: [:matching_fields]

    # not really a scrum master user
    factory :scrum_master do
      sequence(:name) { |n| "scrum_master_#{n}" }
    end

    # not really a developer user
    factory :developer do
      sequence(:name) { |n| "developer_#{n}" }
    end

    # not really a project admin user
    factory :project_admin do
      sequence(:name) { |n| "project_admin_#{n}" }
    end

    factory :admin_user, traits: [:as_admin]

  end

end
