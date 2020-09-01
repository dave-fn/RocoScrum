# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  it { should respond_to :hashid }

  it { should have_secure_password }

  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least 2 }
  it { should validate_presence_of :email }
  it { should have_db_index :email }
  it { should validate_length_of(:password).is_at_least 8 }
  it { should validate_presence_of :password_digest }
  it { should have_db_column :last_logged_at }

  it { should have_one(:admin).dependent(:destroy).inverse_of(:user) }

  it do
    should have_many(:admin_projects).class_name('Project').with_foreign_key(:admin_id).dependent(:destroy).inverse_of(:admin)
  end
  it { should have_many(:admin_teams).through(:admin_projects).source(:teams).class_name('Team') }
  it do
    should have_many(:owned_products).class_name('Product').with_foreign_key(:owner_id).dependent(:nullify).inverse_of(:owner)
  end

  it { should have_many(:team_memberships).dependent(:destroy) }
  it { should have_many(:teams).through(:team_memberships) }
  it { should have_many(:roles).through(:team_memberships) }

  it { should have_many(:projects).through(:teams) }
  it { should have_many(:products).through(:teams) }

  it do
    should have_many(:sbi_developer_status_updates).class_name('SbiStatusUpdate').with_foreign_key(:developer_id)
      .dependent(:nullify).inverse_of(:developer)
  end
  it do
    should have_many(:sbi_creator_status_updates).class_name('SbiStatusUpdate').with_foreign_key(:creator_id)
      .dependent(:nullify).inverse_of(:creator)
  end


  describe 'Uniqueness validations' do
    subject { build :user }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end


  describe '#admin?' do
    let(:admin_user)  { create :user, :as_admin }
    let(:regular_user)  { create :user }

    context 'user has admin access' do
      specify { expect(admin_user.admin?).to eq true }
    end

    context 'user without admin access' do
      specify { expect(regular_user.admin?).to eq false }
    end
  end


  describe '#add_admin_access' do
    let(:admin_user)  { create :user, :as_admin }
    let(:regular_user)  { create :user }

    context 'user already has admin access' do
      before(:each)  { admin_user.add_admin_access }

      it 'keeps admin access' do
        expect(admin_user.admin?).to eq true
      end
    end

    context 'user does not have admin access' do
      before(:each)  { regular_user.add_admin_access }

      it 'grants admin access' do
        expect(regular_user.admin?).to eq true
      end
    end
  end


  describe '#remove_admin_access' do
    let(:admin_user)  { create :user, :as_admin }
    let(:regular_user)  { create :user }

    context 'user already has admin access' do
      before(:each)  { admin_user.remove_admin_access }

      it 'removes admin access' do
        expect(admin_user.admin?).to eq false
      end
    end

    context 'user does not have admin access' do
      before(:each)  { regular_user.remove_admin_access }

      it 'keeps no admin access' do
        expect(regular_user.admin?).to eq false
      end
    end
  end


  describe '#developer?' do
    let(:developer_user)  { team.developers.first }
    let(:team)  { create :working_team, developer_count: 2 }
    let(:regular_user)  { create :user }

    context 'user is a developer member on any team' do
      specify { expect(developer_user.developer?).to eq true }
    end

    context 'user not a developer member on any team' do
      specify { expect(regular_user.developer?).to eq false }
    end
  end


  describe '#scrum_master?' do
    let(:scrum_master_user)  { team.scrum_master }
    let(:team)  { create :working_team, developer_count: 1 }
    let(:regular_user)  { create :user }

    context 'user is the scrum master on any team' do
      specify { expect(scrum_master_user.scrum_master?).to eq true }
    end

    context 'user not the scrum master on any team' do
      specify { expect(regular_user.scrum_master?).to eq false }
    end
  end


  describe '#project_admin?' do
    let(:project_admin_user)  { team.project.admin }
    let(:team)  { create :working_team, developer_count: 1 }
    let(:regular_user)  { create :user }

    context 'user is the project admin on any team' do
      specify { expect(project_admin_user.project_admin?).to eq true }
    end

    context 'user not the project admin on any team' do
      specify { expect(regular_user.project_admin?).to eq false }
    end
  end


  describe '#product_owner?' do
    let!(:product)  { create :product, :with_product_owner, project: team.project }
    let(:product_owner_user)  { product.owner }

    let(:team)  { create :working_team, developer_count: 1, project: (create :project) }
    let(:regular_user)  { create :user }

    context 'user is the product owner on any team' do
      specify { expect(product_owner_user.product_owner?).to eq true }
    end

    context 'user not the product owner on any team' do
      specify { expect(regular_user.product_owner?).to eq false }
    end
  end



end
