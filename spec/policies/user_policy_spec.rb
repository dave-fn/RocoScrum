# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class.new user, record_user }

  let(:resolved_scope)  { described_class::Scope.new(user, User.all).resolve }

  let(:all_users)  { create_list :user, 5 }
  let(:record_user)  { all_users.last }

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

    context 'affecting self' do
      let(:record_user)  { user }

      it { is_expected.to permit_edit_and_update_actions }

      it { is_expected.to forbid_new_and_create_actions }
      it { is_expected.to forbid_action :destroy }
    end

    context 'affecting others' do
      it { is_expected.to forbid_new_and_create_actions }
      it { is_expected.to forbid_edit_and_update_actions }
      it { is_expected.to forbid_action :destroy }
    end
  end

  permissions '.scope' do
    context 'as unauthenticated user' do
      let(:user)  { nil }

      it 'includes all users' do
        expect(resolved_scope).to eq all_users
      end
    end

    context 'as authenticated user' do
      let(:user)  { create :user }

      it 'includes all users' do
        expect(resolved_scope).to include(*all_users)
      end
    end
  end

end
