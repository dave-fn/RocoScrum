class Project < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  belongs_to :admin, class_name: 'User', inverse_of: :projects

end
