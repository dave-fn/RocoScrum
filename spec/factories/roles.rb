FactoryBot.define do

  factory :role do
    name { Faker::Job.title }
    description { name }
    min_participants { 1 }
    max_participants { 1 }

    trait :scrum_master do
      name { 'Scrum Master' }
      # description { 'Scrum Master' }
    end

    trait :product_owner do
      name { 'Product Owner' }
      # description { 'Product Owner' }
    end

    trait :developer do
      name { 'Developer' }
      description { 'Development Team Member' }
      min_participants { 3 }
      max_participants { 9 }
    end

    factory :scrum_master_role, traits: [:scrum_master]
    factory :product_owner_role, traits: [:product_owner]
    factory :developer_role, traits: [:developer]
  end

end
