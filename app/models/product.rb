# frozen_string_literal: true

class Product < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  belongs_to :owner, class_name: 'User', optional: true, inverse_of: :owned_products
  belongs_to :project, inverse_of: :product

  has_many :product_backlog_items, dependent: :destroy, inverse_of: :product
  has_many :backlog_items, -> { order('position') }, through: :product_backlog_items

  scope :owned_by, ->(user) { where(owner: user) }

end
