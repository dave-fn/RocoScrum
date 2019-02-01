FactoryBot.define do

  factory :team do
    project

    trait :with_scrum_master do
      scrum_master
    end

    trait :with_developers do
      transient do
        developer_count { 3 }
      end

      after(:create) do |t, evaluator|
        t.developers = create_list :developer, evaluator.developer_count
      end
    end

    factory :working_team, traits: [:with_scrum_master, :with_developers]
  end
  
end
