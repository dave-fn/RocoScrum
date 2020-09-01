require 'rails_helper'

RSpec.describe ProductPolicy, type: :policy do

  subject { described_class.new user, product }

  let(:resolved_scope)  { described_class::Scope.new(user, Product.all).resolve }

  let(:project_admin)  { create :user }
  let!(:project)  { create :project, admin: project_admin }
  let!(:team)  { create :working_team, project: project }
  let!(:product)  { create :product, :with_product_owner, project: project }

  let!(:other_project)  { create :project }
  let!(:other_team)  { create :working_team, project: other_project }
  let!(:other_product)  { create :product, :with_product_owner, project: other_project }


  context 'as unauthenticated user' do
    let(:user)  { nil }

    it { is_expected.to forbid_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action :destroy }
  end

  context 'as authenticated user' do
    context 'as product owner' do
      let(:user)  { product.owner }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_edit_and_update_actions }
      it { is_expected.to permit_action :destroy }

      it { is_expected.to forbid_new_and_create_actions }
    end

    context 'as team member' do
      let(:user)  { team.scrum_master }
      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }

      it { is_expected.to forbid_new_and_create_actions }
      it { is_expected.to forbid_edit_and_update_actions }
      it { is_expected.to forbid_action :destroy }
    end

    context 'as project admin' do
      let(:user)  { project_admin }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_edit_and_update_actions }
      it { is_expected.to permit_action :destroy }
      it { is_expected.to permit_new_and_create_actions }
    end

    context 'as admin' do
      let(:user)  { create :admin_user }

      it { is_expected.to permit_action :index }
      it { is_expected.to permit_action :show }
      it { is_expected.to permit_edit_and_update_actions }
      it { is_expected.to permit_action :destroy }
      it { is_expected.to permit_new_and_create_actions }
    end
  end

  permissions '.scope' do
    context 'as unauthenticated user' do
      let(:user)  { nil }

      it 'returns empty array' do
        expect(resolved_scope).to be_empty
      end
    end

    context 'as authenticated user' do
      context 'as product owner' do
        let(:user)  { product.owner }

        it 'returns owned products' do
          expect(resolved_scope).to include product
        end
      end

      context 'as team member' do
        let(:user)  { team.scrum_master }

        it 'returns products linked to team projects' do
          expect(resolved_scope).to include product
        end
      end

      context 'as project admin' do
        let(:user)  { project_admin }

        it 'returns products linked to project' do
          expect(resolved_scope).to include product
        end
      end

      context 'as admin' do
        let(:user)  { create :admin_user }

        it 'returns all products' do
          expect(resolved_scope).to include(product).and include(other_product)
        end
      end
    end
  end

end
