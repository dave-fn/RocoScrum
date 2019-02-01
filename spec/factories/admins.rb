FactoryBot.define do

  factory :admin do
    association :user, factory: [:dummy_user]

    factory :user_admin do
      user
    end

  end


end
