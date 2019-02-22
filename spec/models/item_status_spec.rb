# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemStatus, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:context) }

  it { should have_db_index(:team_id) }
  it { should have_db_index(:context) }
  it { should have_db_index([:team_id, :context, :title]).unique }
  it { should have_db_column(:title).with_options(null: false) }
  it { should have_db_column(:context).with_options(limit: 5, null: false) }

  it { should belong_to(:team).inverse_of(:item_statuses).optional }


  describe 'Uniqueness validations' do
    subject  { build :item_status }

    it { should validate_uniqueness_of(:title).scoped_to([:team_id, :context]) }
  end

end
