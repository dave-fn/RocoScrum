class User < ApplicationRecord

  include Hashid::Rails
  
  # bcrypt - password_digest
  has_secure_password

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, allow_blank: false
  validates :password, length: { minimum: 8 }, confirmation: true, allow_nil: true, allow_blank: false
  validates :password_digest, presence: true

  before_validation { change_case_of_email }

  has_one :admin, dependent: :destroy, inverse_of: :user
  has_many :projects, dependent: :destroy, foreign_key: 'admin_id', inverse_of: :admin
  has_many :admin_teams, through: :projects, source: :teams, class_name: 'Team'

  has_many :team_memberships, inverse_of: :user
  has_many :teams, through: :team_memberships
  has_many :roles, through: :team_memberships

  scope :admins, -> { joins(:admin) }


  # Knock override
  def to_token_payload
    {sub: hashid}
  end


  def admin?
    self.admin != nil
  end

  def developer?
    roles.include? Role.developer
  end

  def scrum_master?
    roles.include? Role.scrum_master
  end

  def project_admin?
    projects.any? { |proj| proj.admin == self }
  end


  private

  def change_case_of_email
    self.email = email.to_s.downcase
  end

end
