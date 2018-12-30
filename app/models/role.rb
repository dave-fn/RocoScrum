class Role < ApplicationRecord

  include Hashid::Rails
  
  validates :name, presence: true
  validates :description, presence: true
  validates :min_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { greater_than_or_equal_to: 1 }

end
