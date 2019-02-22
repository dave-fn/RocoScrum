# frozen_string_literal: true

class User < ApplicationRecord

  include Hashid::Rails

  # bcrypt - password_digest
  has_secure_password

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, allow_blank: false
  validates :password, length: { minimum: 8 }, confirmation: true, allow_nil: true, allow_blank: false
  validates :password_digest, presence: true

  before_validation { change_case_of_email }

  # System Admin
  has_one :admin, dependent: :destroy, inverse_of: :user

  # Project Admin
  has_many :admin_projects, class_name: 'Project', foreign_key: 'admin_id', dependent: :destroy, inverse_of: :admin
  has_many :admin_teams, through: :admin_projects, source: :teams, class_name: 'Team'

  # Product Owner
  has_many :owned_products, class_name: 'Product', foreign_key: 'owner_id', dependent: :nullify, inverse_of: :owner

  # Team Member
  has_many :team_memberships, dependent: :destroy, inverse_of: :user
  has_many :teams, through: :team_memberships
  has_many :roles, through: :team_memberships

  # Sprint Backlog Item Status Updates
  has_many :sbi_developer_status_updates, class_name: 'SbiStatusUpdate', foreign_key: 'developer_id',
                                          dependent: :nullify, inverse_of: :developer
  has_many :sbi_creator_status_updates, class_name: 'SbiStatusUpdate', foreign_key: 'creator_id',
                                        dependent: :nullify, inverse_of: :creator

  # Scopes
  scope :admins, -> { joins(:admin) }

  # Knock override
  def to_token_payload
    { sub: hashid }
  end

  # Access
  def add_admin_access
    create_admin unless admin?
  end

  def remove_admin_access
    admin.destroy if admin?
    self.admin = nil
  end

  # Helpers
  def admin?
    admin != nil
  end

  def developer?
    roles.include? Role.developer
  end

  def scrum_master?
    roles.include? Role.scrum_master
  end

  def project_admin?
    admin_projects.any?
  end

  def product_owner?
    owned_products.any?
  end


  private

  def change_case_of_email
    self.email = email.to_s.downcase
  end

end
