# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of :name }
  it { should validate_numericality_of(:timebox).is_greater_than_or_equal_to(1) }


  describe 'Uniqueness validations' do
    subject  { build :sprint_event }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end

end
