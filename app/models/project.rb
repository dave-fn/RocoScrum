# frozen_string_literal: true

class Project < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  belongs_to :admin, class_name: 'User', inverse_of: :projects
  has_many :teams, dependent: :destroy, inverse_of: :project

  scope :admin_by, ->(user) { where(admin: user) }

end
