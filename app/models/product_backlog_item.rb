class ProductBacklogItem < ApplicationRecord
  belongs_to :product
  belongs_to :backlog_item
end
