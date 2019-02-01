FactoryBot.define do

  factory :user, aliases: [:member] do
    name { Faker::Internet.username(8..15) }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }

    trait :matching_fields do
      email { Faker::Internet.safe_email(name) }
      password { name }
    end

    factory :dummy_user, traits: [:matching_fields]
  end

end
