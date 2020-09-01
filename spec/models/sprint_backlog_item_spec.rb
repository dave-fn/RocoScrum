# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SprintBacklogItem, type: :model do

  it { should belong_to(:sprint).inverse_of(:sprint_backlog_items) }
  it { should belong_to(:backlog_item).inverse_of(:sprint_backlog_items) }
  it { should belong_to(:team).inverse_of(:sprint_backlog_items) }

  it { should validate_numericality_of(:position).only_integer }
  it { should_not validate_presence_of(:position) }

  it do
    should have_many(:status_updates).class_name('SbiStatusUpdate')
      .dependent(:restrict_with_exception).inverse_of(:sprint_backlog_item)
  end


  describe 'Uniqueness validations' do
    subject  { build :sprint_backlog_item }

    it { should validate_uniqueness_of(:sprint_id).scoped_to(:backlog_item_id) }
    it { should validate_uniqueness_of(:backlog_item_id).scoped_to(:sprint_id) }
    it { should validate_uniqueness_of(:position).scoped_to(:sprint_id) }
  end

end
