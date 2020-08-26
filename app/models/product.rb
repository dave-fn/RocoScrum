# frozen_string_literal: true

class Product < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  # Project
  belongs_to :project, inverse_of: :product

  # Product Owner
  belongs_to :owner, class_name: 'User', optional: true, inverse_of: :owned_products

  # Backlog
  has_many :product_backlog_items, -> { ordered_by_position }, dependent: :destroy, inverse_of: :product
  has_many :backlog_items, through: :product_backlog_items

  # Scopes
  scope :owned_by, ->(user) { where(owner: user) }
  scope :of_project_admin_by, ->(user) { where(project: Project.admin_by(user)) }
  scope :having_team_member, ->(user) { where(project: Project.having_team_member(user)) }

end
