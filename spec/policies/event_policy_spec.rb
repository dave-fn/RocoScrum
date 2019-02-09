require 'rails_helper'

RSpec.describe EventPolicy do

  subject { described_class.new user, described_class }

  let(:resolved_scope)  { described_class::Scope.new(user, Event.all).resolve }

  let!(:sprint_event)  { create(:sprint_event) }
  let!(:sprint_planning_event)  { create(:sprint_planning_event) }
  let!(:daily_scrum_event)  { create(:daily_scrum_event) }
  let(:scrum_events)  { [sprint_event, sprint_planning_event, daily_scrum_event] }

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
        expect(resolved_scope).to eq scrum_events
      end
    end

    context 'as authenticated user' do
      let(:user)  { create :user }

      it 'includes all roles' do
        expect(resolved_scope).to eq scrum_events
      end
    end
  end

end
