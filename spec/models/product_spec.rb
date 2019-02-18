# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do

  it { should respond_to :hashid }

  it { should validate_presence_of :title }

  it { should belong_to(:project).inverse_of(:product) }
  it { should belong_to(:owner).class_name('User').inverse_of(:owned_products).optional }

  it { should have_many(:product_backlog_items).dependent(:destroy).inverse_of(:product) }
  it { should have_many(:backlog_items).through(:product_backlog_items) }

end
