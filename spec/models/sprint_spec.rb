# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sprint, type: :model do

  it { should respond_to :hashid }

  it { should validate_presence_of :title }
  it { should allow_value(nil).for(:started_at) }

  it { should have_many(:sprint_backlog_items).dependent(:destroy).inverse_of(:sprint) }
  it { should have_many(:backlog_items).through(:sprint_backlog_items) }

  it { should have_one(:project_sprint).dependent(:destroy).inverse_of(:sprint) }
  it { should have_one(:project).through(:project_sprint) }

  describe '#started?' do
    context 'when started_at not set' do
      let(:sprint)  { build :sprint }

      specify { expect(sprint.started?).to eq false }
    end

    context 'when started_at is set' do
      let(:sprint)  { build :sprint, :started }

      specify { expect(sprint.started?).to eq true }
    end
  end

end
