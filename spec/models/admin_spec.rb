require 'rails_helper'

RSpec.describe Admin, type: :model do

  it { should belong_to(:user).inverse_of(:admin).required }
  it { should have_db_index(:user_id).unique }

  # describe 'factories' do
  #   describe 'admin default' do
  #     let(:admin)  { build :admin }

  #     specify { expect(admin.user).to eq nil }
  #   end

  #   describe 'admin' do
  #     let(:admin)  { build :admin, user: user }
  #     let(:user)  { build :user }

  #     specify { expect(admin.user).to eq user }
  #   end

  #   describe 'user admin' do
  #     let(:admin)  { build :user_admin }

  #     specify { expect(admin.user).to_not eq nil }
  #   end
  # end
  
end
