# frozen_string_literal: true

class BacklogItem < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  # Product
  has_one :product_backlog_item, dependent: :destroy, inverse_of: :backlog_item
  has_one :product, through: :product_backlog_item

  # Sprint
  has_one :sprint_backlog_item, dependent: :destroy, inverse_of: :backlog_item

end
