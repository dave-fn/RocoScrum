require 'rails_helper'

RSpec.describe Team, type: :model do

  it { should respond_to :hashid }

  it { should belong_to(:project).inverse_of(:teams).required }

  it { should have_many(:team_memberships).inverse_of(:team) }
  it { should have_many(:members).through(:team_memberships).source(:user) }
  it { should have_one(:scrum_master).source(:user) }
  it { should have_many(:developers).source(:user) }

  describe '#size' do
    pending 'test size with dummy team, create factory to ease creation of teams'
  end

end
