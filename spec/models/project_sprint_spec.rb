# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectSprint, type: :model do

  it { should belong_to(:project).inverse_of(:project_sprints) }
  it { should belong_to(:sprint).inverse_of(:project_sprint) }

end
