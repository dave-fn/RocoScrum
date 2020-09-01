# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectSprint, type: :model do

  it { should belong_to(:project).inverse_of(:project_sprints) }
  it { should belong_to(:sprint).inverse_of(:project_sprint) }

  it { should validate_numericality_of(:position).only_integer.allow_nil }
  it { should_not validate_presence_of(:position) }


  describe 'Uniqueness validations' do
    subject  { build :project_sprint }

    it { should validate_uniqueness_of(:project_id).scoped_to(:sprint_id) }
    it { should validate_uniqueness_of(:sprint_id).scoped_to(:project_id) }
    it { should validate_uniqueness_of(:position).scoped_to(:project_id) }
  end

end
