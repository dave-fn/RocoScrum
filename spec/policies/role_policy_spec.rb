# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RolePolicy do

  subject { described_class.new user, developer_role }

  let(:resolved_scope)  { described_class::Scope.new(user, Role.all).resolve }

  let!(:scrum_master_role)  { create(:scrum_master_role) }
  let!(:product_owner_role)  { create(:product_owner_role) }
  let!(:developer_role)  { create(:developer_role) }
  let(:scrum_roles)  { [scrum_master_role, product_owner_role, developer_role] }

  context 'as unauthenticated user' do
    let(:user)  { nil }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  context 'as authenticated user' do
    let(:user) { create :user }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  permissions '.scope' do
    context 'as unauthenticated user' do
      let(:user)  { nil }

      it 'includes all roles' do
        expect(resolved_scope).to eq scrum_roles
      end
    end

    context 'as authenticated user' do
      let(:user)  { create :user }

      it 'includes all roles' do
        expect(resolved_scope).to eq scrum_roles
      end
    end
  end

end
