# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should respond_to :hashid }

  it { should validate_presence_of :title }

  it { should belong_to(:admin).class_name('User').inverse_of(:admin_projects).required }
  it { should have_many(:teams).inverse_of(:project).dependent(:destroy) }

  it { should have_one(:product).dependent(:destroy).inverse_of(:project) }

end
