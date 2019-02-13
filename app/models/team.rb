# frozen_string_literal: true

class Team < ApplicationRecord

  include Hashid::Rails

  belongs_to :project, inverse_of: :teams
  has_one :project_admin, through: :project, class_name: 'User', source: :admin

  has_one :product, through: :project

  # Product Owner
  has_one :product_owner, through: :product, source: :owner

  # All Members
  has_many :team_memberships, dependent: :destroy, inverse_of: :team
  has_many :members, through: :team_memberships, source: :user

  # Scrum Master
  # rubocop:disable Rails/InverseOf
  has_one :scrum_master_membership, -> { scrum_masters }, class_name: 'TeamMembership', dependent: :destroy
  has_one :scrum_master, through: :scrum_master_membership, source: :user

  # Developers
  has_many :developers_membership, -> { developers }, class_name: 'TeamMembership', dependent: :destroy
  has_many :developers, through: :developers_membership, source: :user
  # , before_add: :limit_adding_developer, before_remove: :limit_removing_developer
  # rubocop:enable Rails/InverseOf

  validates_each :developers do |record, attribute, value|
    if value.present?
      record.errors.add(attribute, 'too few assigned') if value.size < min_developers
      record.errors.add(attribute, 'too many assigned') if value.size > max_developers
    end
  end

  def size
    return team_memberships.size if product_owner.nil?
    team_memberships.size + 1
  end

  def self.max_developers
    @max_developers ||= Role.developer.max_participants
  end

  def self.min_developers
    @min_developers ||= Role.developer.min_participants
  end

  private_class_method :max_developers, :min_developers


  private

  def limit_adding_developer(_developer)
    too_many_developers! if developers.size >= self.class.max_developers
  end

  def limit_removing_developer(_developer)
    not_enough_developers! if developers.size <= self.class.min_developers
  end

  # rubocop:disable Layout/EmptyLinesAroundModuleBody
  module Errors
    class MaxDevelopers < StandardError; end
    class MinDevelopers < StandardError; end
  end
  # rubocop:enable Layout/EmptyLinesAroundModuleBody

  def too_many_developers!
    raise Errors::MaxDevelopers, "Limited to at most #{self.class.max_developers} developers"
  end

  def not_enough_developers!
    raise Errors::MinDevelopers, "Requires at least #{self.class.min_developers} developers"
  end

end
