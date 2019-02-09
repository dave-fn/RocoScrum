FactoryBot.define do

  factory :team do
    project

    trait :with_scrum_master do
      before(:create) do
        create :scrum_master_role
      end

      after(:create) do |t, evaluator|
        t.scrum_master = create :user, :scrum_master_name
      end
    end

    trait :with_developers do
      transient do
        developer_count { 3 }
      end

      before(:create) do
        create :developer_role
      end

      after(:create) do |t, evaluator|
        t.developers = create_list :user, evaluator.developer_count, :developer_name
      end
    end

    factory :working_team, traits: [:with_scrum_master, :with_developers]
  end
  
end
