class Team < ApplicationRecord

  include Hashid::Rails

  belongs_to :project, inverse_of: :teams

  # All Members
  has_many :team_memberships, inverse_of: :team
  has_many :members, through: :team_memberships, source: :user
  
  # Scrum Master
  has_one :scrum_master_membership, -> { scrum_masters }, class_name: 'TeamMembership'
  has_one :scrum_master, through: :scrum_master_membership, source: :user
  
  # Developers
  has_many :developers_membership, -> { developers }, class_name: 'TeamMembership'
  has_many :developers, through: :developers_membership, source: :user

  def size
    team_memberships.size
  end

end
