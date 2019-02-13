# frozen_string_literal: true

class BacklogItem < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  has_one :product_backlog_item, dependent: :destroy, inverse_of: :backlog_item

end
