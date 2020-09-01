# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductBacklogItem, type: :model do

  it { should belong_to(:product).inverse_of(:product_backlog_items) }
  it { should belong_to(:backlog_item).inverse_of(:product_backlog_item) }

  it { should validate_numericality_of(:position).only_integer.allow_nil }
  it { should_not validate_presence_of(:position) }


  describe 'Uniqueness validations' do
    subject  { build :product_backlog_item }

    it { should validate_uniqueness_of(:product_id).scoped_to(:backlog_item_id) }
    it { should validate_uniqueness_of(:backlog_item_id).scoped_to(:product_id) }
    it { should validate_uniqueness_of(:position).scoped_to(:product_id) }
  end

end
