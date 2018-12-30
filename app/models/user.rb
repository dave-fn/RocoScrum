class User < ApplicationRecord

  # bcrypt - password_digest
  has_secure_password

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, allow_blank: false
  validates :password, length: { minimum: 8 }, confirmation: true, allow_nil: true, allow_blank: false
  validates :password_digest, presence: true

  before_validation { change_case_of_email }


  private

  def change_case_of_email
    self.email = email.to_s.downcase
  end

end
