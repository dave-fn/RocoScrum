# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectPolicy do

  subject { described_class.new user, project }

  let(:resolved_scope)  { described_class::Scope.new(user, Project.all).resolve }

  let!(:projects)  { create_list :project, 4, admin: project_admin }
  let(:project)  { projects.first }

  context 'as unauthenticated user' do
    let(:user)  { nil }
    let(:project_admin)  { create :user }

    it { is_expected.to forbid_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  context 'as authenticated user' do
    context 'for non-administered project' do
      let(:user)  { create :user }
      let(:extra_project)  { create :project, admin: user }
      let(:project_admin)  { create :user }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_new_and_create_actions }

      it { is_expected.to forbid_action :show }
      it { is_expected.to forbid_edit_and_update_actions }
      it { is_expected.to forbid_action :destroy }

      permissions '.scope' do
        it 'returns administered projects' do
          expect(resolved_scope).to eq user.admin_projects
        end
      end
    end

    context 'for administered project' do
      let(:user)  { project_admin }
      let(:project_admin)  { create :user }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_new_and_create_actions }
      it { is_expected.to permit_edit_and_update_actions }
      it { is_expected.to permit_action :destroy }

      permissions '.scope' do
        it 'returns administered projects' do
          expect(resolved_scope).to eq project_admin.admin_projects
        end
      end
    end
  end

end
