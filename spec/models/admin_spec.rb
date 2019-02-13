# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do

  it { should belong_to(:user).inverse_of(:admin).required }
  it { should have_db_index(:user_id).unique }

end
