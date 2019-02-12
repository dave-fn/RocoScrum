# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do

  it { should validate_presence_of :title }

  it { should belong_to(:project).inverse_of(:product) }
  it { should belong_to(:owner).class_name('User').inverse_of(:products).optional }

end
