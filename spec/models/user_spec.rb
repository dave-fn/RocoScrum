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


  describe '#admin?' do
    let(:admin_user)  { create :dummy_user, admin: (create :user_admin) }
    let(:regular_user)  { create :dummy_user }

    context 'user has admin access' do
      specify { expect(admin_user.admin?).to eq true }
    end

    context 'user without admin access' do
      specify { expect(regular_user.admin?).to eq false }
    end
  end

end
