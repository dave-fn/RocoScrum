# frozen_string_literal: true

class TeamMembership < ApplicationRecord

  belongs_to :team, inverse_of: :team_memberships
  belongs_to :user, inverse_of: :team_memberships
  belongs_to :role, inverse_of: :team_memberships

  scope :scrum_masters, -> { where(role: Role.scrum_master) }
  scope :developers, -> { where(role: Role.developer) }

end
