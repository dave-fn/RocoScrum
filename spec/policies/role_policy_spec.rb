require 'rails_helper'

RSpec.describe RolePolicy do

  subject { described_class.new user, described_class }

  let!(:scrum_master_role)  { create(:scrum_master_role) }
  let!(:product_owner_role)  { create(:product_owner_role) }
  let!(:developer_role)  { create(:developer_role) }

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

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
