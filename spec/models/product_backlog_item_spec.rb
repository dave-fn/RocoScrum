# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductBacklogItem, type: :model do

  it { should belong_to(:product).inverse_of(:product_backlog_items) }
  it { should belong_to(:backlog_item).inverse_of(:product_backlog_item) }

end
