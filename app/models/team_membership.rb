# frozen_string_literal: true

class TeamMembership < ApplicationRecord

  # Association
  belongs_to :team, inverse_of: :team_memberships
  belongs_to :user, inverse_of: :team_memberships
  belongs_to :role, inverse_of: :team_memberships

  # Scopes
  scope :scrum_masters, -> { where(role: Role.scrum_master) }
  scope :developers, -> { where(role: Role.developer) }

end
