require 'rails_helper'

RSpec.describe TeamPolicy do
  
  subject { described_class.new user, team }

  let(:resolved_scope)  { described_class::Scope.new(user, Team.all).resolve }

  let!(:project)  { create :project, admin: project_admin }
  let!(:team)  { create :team, project: project }

  context 'as unauthenticated user' do
    let(:user)  { nil }
    let(:project_admin)  { create :dummy_user }

    it { is_expected.to forbid_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  context 'as authenticated user' do
    context 'for non-administered project' do
      let(:user)  { create :dummy_user }
      let!(:extra_project)  { create :project, admin: user }
      let(:project_admin)  { create :dummy_user }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_new_and_create_actions }

      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_edit_and_update_actions }
      it { is_expected.to forbid_action :destroy }

      permissions '.scope' do
        it 'returns administered projects' do
          expect(resolved_scope).to eq user.admin_teams
        end
      end
    end

    context 'for administered project' do
      let(:user)  { project_admin }
      let(:project_admin)  { create :dummy_user }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_new_and_create_actions }
      it { is_expected.to permit_edit_and_update_actions }
      it { is_expected.to permit_action :destroy }

      permissions '.scope' do
        it 'returns administered projects' do
          expect(resolved_scope).to eq project_admin.admin_teams
        end
      end
    end
  end

end
