# frozen_string_literal: true

class Role < ApplicationRecord

  include Hashid::Rails

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :min_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }

  # Scopes
  scope :scrum_master, -> do
    @scrum_master_role ||= find_or_create_by(name: 'Scrum Master') { |r| r.description = r.name }
  end
  scope :product_owner, -> do
    @product_owner_role ||= find_or_create_by(name: 'Product Owner') { |r| r.description = r.name }
  end
  scope :developer, -> do
    @developer_role ||= find_or_create_by(name: 'Developer') { |r| r.description = r.name }
  end

  # Team Members
  has_many :team_memberships, dependent: :restrict_with_exception, inverse_of: :role
  has_many :teams, through: :team_memberships
  has_many :users, through: :team_memberships

end
