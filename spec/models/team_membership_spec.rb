# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamMembership, type: :model do

  it { should belong_to(:team).inverse_of(:team_memberships) }
  it { should belong_to(:user).inverse_of(:team_memberships) }
  it { should belong_to(:role).inverse_of(:team_memberships) }

  specify { expect(described_class).to respond_to(:scrum_masters) }
  specify { expect(described_class).to respond_to(:developers) }

end
