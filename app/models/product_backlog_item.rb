# frozen_string_literal: true

class ProductBacklogItem < ApplicationRecord

  belongs_to :product, inverse_of: :product_backlog_items
  belongs_to :backlog_item, inverse_of: :product_backlog_item

end
