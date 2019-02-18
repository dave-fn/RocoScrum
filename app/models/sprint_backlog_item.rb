# frozen_string_literal: true

class SprintBacklogItem < ApplicationRecord

  validates :sprint_id, uniqueness: { scope: [:backlog_item_id] }
  validates :backlog_item_id, uniqueness: { scope: [:sprint_id] }
  validates :position, uniqueness: { scope: [:sprint_id] }, numericality: { only_integer: true }

  # Association
  belongs_to :sprint, inverse_of: :sprint_backlog_items
  belongs_to :backlog_item, inverse_of: :sprint_backlog_items
  belongs_to :team, optional: true, inverse_of: :sprint_backlog_items

  # Scopes
  scope :for_sprint, ->(sprint) { where(sprint: sprint) }
  scope :for_team, ->(team) { where(team: team) }

end
