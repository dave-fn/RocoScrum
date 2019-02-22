class SbiStatusUpdate < ApplicationRecord
  belongs_to :sprint_backlog_item
  belongs_to :item_status
  belongs_to :developer
  belongs_to :creator
end
