require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of :name }
  it { should validate_numericality_of(:timebox).is_greater_than_or_equal_to(1) }

  describe 'Uniqueness validations' do
    subject { build(:sprint_event) }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  # describe 'factories' do
  #   describe 'sprint' do
  #     let(:event)  { build(:sprint_event) }

  #     specify { expect(event.name).to eq 'Sprint' }
  #     specify { expect(event.timebox).to eq 1.month }
  #   end

  #   describe 'daily scrum' do
  #     let(:event)  { build(:daily_scrum_event) }

  #     specify { expect(event.name).to eq 'Daily Scrum' }
  #     specify { expect(event.timebox).to eq 15.minutes }
  #   end
  # end
  
end
