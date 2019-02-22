# frozen_string_literal: true

FactoryBot.define do

  factory :item_status do

    context { 'SBI' }
    title { Faker::Hacker.ingverb }
    description { Faker::Hipster.sentences(1) }

    trait :matching_description do
      description { title }
    end

    trait :sbi_committed do
      title { 'Committed' }
    end

    trait :sbi_assigned do
      title { 'Assigned' }
    end

    trait :sbi_in_progress do
      title { 'In Progress' }
    end

    trait :sbi_completed do
      title { 'Completed' }
    end

    trait :sbi_pending do
      title { 'Pending' }
    end

    factory :sbi_committed_status, traits: [:sbi_committed, :matching_description]
    factory :sbi_assigned_status, traits: [:sbi_assigned, :matching_description]
    factory :sbi_in_progress_status, traits: [:sbi_in_progress, :matching_description]
    factory :sbi_completed_status, traits: [:sbi_completed, :matching_description]
    factory :sbi_pending_status, traits: [:sbi_pending, :matching_description]

    trait :with_team do
      team
    end
  end

end
