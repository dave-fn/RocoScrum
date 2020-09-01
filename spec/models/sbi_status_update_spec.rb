# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SbiStatusUpdate, type: :model do

  it { should belong_to(:sprint_backlog_item).inverse_of(:status_updates) }
  it { should belong_to(:item_status).inverse_of(:sbi_status_updates) }
  it { should belong_to(:developer).class_name('User').inverse_of(:sbi_developer_status_updates) }
  it { should belong_to(:creator).class_name('User').inverse_of(:sbi_creator_status_updates) }

end
