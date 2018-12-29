FactoryBot.define do
  factory :role do
    name { "MyString" }
    description { "MyString" }
    min_participants { 1 }
    max_participants { 1 }
  end
end
