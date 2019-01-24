class Role < ApplicationRecord

  include Hashid::Rails
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :min_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }

  scope :scrum_master, -> { find_by(name: 'Scrum Master') }
  scope :product_owner, -> { find_by(name: 'Product Owner') }
  scope :developer , -> { find_by(name: 'Developer') }

  has_many :team_memberships, inverse_of: :role
  has_many :teams, through: :team_memberships
  has_many :users, through: :team_memberships

end
