FactoryBot.define do

  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }

    trait :matching_fields do
      email { Faker::Internet.safe_email(name) }
      password { name }
    end

    factory :dummy_user, traits: [:matching_fields]
  end

end
