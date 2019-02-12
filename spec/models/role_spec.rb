# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :min_participants }
  it { should validate_numericality_of(:min_participants).is_greater_than_or_equal_to(1) }
  it { should validate_presence_of :max_participants }
  it { should validate_numericality_of(:max_participants).is_greater_than_or_equal_to(1) }

  it { should have_many(:team_memberships).inverse_of(:role).dependent(:restrict_with_exception) }
  it { should have_many(:teams).through(:team_memberships) }
  it { should have_many(:users).through(:team_memberships) }

  describe 'Uniqueness validations' do
    subject { build(:scrum_master_role) }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe '.scrum_master' do
    let!(:all_roles)  { [:scrum_master_role, :developer_role, :product_owner_role].each { |factory| create(*factory) } }

    it 'returns correct instance' do
      expect(Role.scrum_master.name).to eq 'Scrum Master'
    end
  end

  describe '.developer' do
    let!(:all_roles)  { [:scrum_master_role, :developer_role, :product_owner_role].each { |factory| create(*factory) } }

    it 'returns correct instance' do
      expect(Role.developer.name).to eq 'Developer'
    end
  end

  describe '.product_owner' do
    let!(:all_roles)  { [:scrum_master_role, :developer_role, :product_owner_role].each { |factory| create(*factory) } }

    it 'returns correct instance' do
      expect(Role.product_owner.name).to eq 'Product Owner'
    end
  end

  # describe 'factories' do
  #   describe 'scrum master' do
  #     let(:scrum_master)  { build(:scrum_master_role) }

  #     specify { expect(scrum_master.name).to eq 'Scrum Master' }
  #     specify { expect(scrum_master.min_participants).to eq 1 }
  #     specify { expect(scrum_master.max_participants).to eq 1 }
  #   end

  #   describe 'development team member' do
  #     let(:developer)  { build(:developer_role) }

  #     specify { expect(developer.name).to eq 'Developer' }
  #     specify { expect(developer.min_participants).to eq 3 }
  #     specify { expect(developer.max_participants).to eq 9 }
  #   end
  # end

end
