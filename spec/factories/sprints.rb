FactoryBot.define do
  factory :sprint do
    title { "MyString" }
    description { "MyText" }
    goal { "MyText" }
    duration { 1 }
    started_at { "2019-02-13 13:00:40" }
  end
end
