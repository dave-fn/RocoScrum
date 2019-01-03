class Admin < ApplicationRecord
  belongs_to :user, inverse_of: :admin

  def self.users
    all.map { |admin| admin.user }
  end
  
end
