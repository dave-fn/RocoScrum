class SprintBacklogItem < ApplicationRecord
  belongs_to :sprint
  belongs_to :backlog_item
  belongs_to :team
end
