FactoryBot.define do

  factory :project do
    title { Faker::Device.model_name }
    description { Faker::Lorem.paragraph }
    admin { nil }
  end

end
