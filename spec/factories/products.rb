FactoryBot.define do
  factory :product do
    title { "MyString" }
    description { "MyText" }
    owner { nil }
    project { nil }
  end
end
