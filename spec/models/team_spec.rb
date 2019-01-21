require 'rails_helper'

RSpec.describe Team, type: :model do

  it { should respond_to :hashid }
  it { should belong_to(:project).inverse_of(:teams).required }

end
