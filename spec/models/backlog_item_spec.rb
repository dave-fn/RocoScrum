# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BacklogItem, type: :model do

  it { should validate_presence_of :title }
  it { should allow_value(nil).for(:ready) }

  it { should have_one(:product_backlog_item).dependent(:destroy).inverse_of(:backlog_item) }
  it { should have_one(:product).through(:product_backlog_item) }

end
