require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_secure_password }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least 2 }
  it { should validate_presence_of :email }
  it { should have_db_index :email }
  it { should validate_length_of(:password).is_at_least 8 }
  it { should validate_presence_of :password_digest }
  it { should have_db_column :last_logged_at }

  it { should have_one(:admin).dependent(:destroy).optional }
  # it { should have_one(:admin).dependent(:destroy).inverse_of(:users).optional }

  describe 'Uniqueness validations' do
    subject { build(:dummy_user) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

end
