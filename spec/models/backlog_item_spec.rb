# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BacklogItem, type: :model do

  it { should validate_presence_of :title }
  it { should allow_value(nil).for(:ready) }

end
