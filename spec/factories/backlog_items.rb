FactoryBot.define do
  factory :backlog_item do
    title { "MyString" }
    requirement { "MyText" }
    description { "MyText" }
    ready { false }
  end
end
