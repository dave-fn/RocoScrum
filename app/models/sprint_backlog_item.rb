# frozen_string_literal: true

class SprintBacklogItem < ApplicationRecord

  belongs_to :sprint, inverse_of: :sprint_backlog_items
  belongs_to :backlog_item, inverse_of: :sprint_backlog_item
  belongs_to :team, inverse_of: :sprint_backlog_items

  validates :sprint_id, uniqueness: { scope: [:backlog_item_id] }
  validates :backlog_item_id, uniqueness: { scope: [:sprint_id] }

  validates :position, uniqueness: { scope: [:sprint_id] }, numericality: { only_integer: true }

end
