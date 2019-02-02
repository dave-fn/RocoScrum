class Team < ApplicationRecord

  include Hashid::Rails

  # validates :developers, length: {minimum: Role.developer.min_participants, maximum: Role.developer.max_participants }
  # validates :developers, length: {minimum: 1, maximum: 9, message: "instances outside min/max values."}

  belongs_to :project, inverse_of: :teams

  # All Members
  has_many :team_memberships, inverse_of: :team
  has_many :members, through: :team_memberships, source: :user
  
  # Scrum Master
  has_one :scrum_master_membership, -> { scrum_masters }, class_name: 'TeamMembership'
  has_one :scrum_master, through: :scrum_master_membership, source: :user
  
  # Developers
  has_many :developers_membership, -> { developers }, class_name: 'TeamMembership'
  has_many :developers, through: :developers_membership, source: :user, before_add: :limit_adding_developers

  def size
    team_memberships.size
  end


  private

  def limit_adding_developers(developer)
    too_many_developers! if developers.size >= max_developers
  end

  def max_developers
    @max_developers ||= Role.developer.max_participants
  end

  module Errors
    class MaxDevelopers < StandardError; end
  end

  def too_many_developers!
    raise Errors::MaxDevelopers, "Limited to at most #{max_developers} developers"
  end

  # def count_team_developers
  #   errors.add(:developers, :too_short, count: 3) if developers.size < 3
  #   errors.add(:developers, :too_long, count: 9) if developers.size > 9
  # end

end
