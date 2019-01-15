require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class.new user, described_class }

  let(:resolved_scope)  { described_class::Scope.new(user, User.all).resolve }

  let!(:all_users)  { create_list :dummy_user, 5 }

  context 'as unauthenticated user' do
    let(:user)  { nil }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  context 'as authenticated user' do
    let(:user) { create :dummy_user }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  permissions '.scope' do
    context 'as unauthenticated user' do
      let(:user)  { nil }

      it 'includes all users' do
        expect(resolved_scope).to eq all_users
      end
    end

    context 'as authenticated user' do
      let(:user)  { create :dummy_user }

      it 'includes all users' do
        expect(resolved_scope).to include *all_users
      end
    end
  end

end