class TeamMembership < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :role
end
