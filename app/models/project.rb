# frozen_string_literal: true

class Project < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  # Administration
  belongs_to :admin, class_name: 'User', inverse_of: :admin_projects

  # Teams
  has_many :teams, dependent: :destroy, inverse_of: :project

  # Product
  has_one :product, dependent: :destroy, inverse_of: :project

  # Sprints
  has_many :project_sprints, dependent: :destroy, inverse_of: :project
  has_many :sprints, through: :project_sprints

  # Scopes
  scope :admin_by, ->(user) { where(admin: user) }

end
