FactoryBot.define do

  factory :project do
    title { Faker::Device.model_name }
    association :admin, factory: [:project_admin]

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end
  end

end
