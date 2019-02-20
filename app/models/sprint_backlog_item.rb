# frozen_string_literal: true

class SprintBacklogItem < ApplicationRecord

  validates :sprint_id, uniqueness: { scope: [:backlog_item_id] }
  validates :backlog_item_id, uniqueness: { scope: [:sprint_id] }
  # validates :position, uniqueness: { scope: [:sprint_id] }, numericality: { only_integer: true }
  validates :position, numericality: { only_integer: true }, allow_nil: true

  # Association
  belongs_to :sprint, inverse_of: :sprint_backlog_items
  belongs_to :backlog_item, inverse_of: :sprint_backlog_items
  belongs_to :team, inverse_of: :sprint_backlog_items

  # Scopes
  scope :for_sprint, ->(sprint) { where(sprint: sprint) }
  scope :for_team, ->(team) { where(team: team) }
  scope :ordered_by_sprint, -> { order(sprint_id: :asc) }
  scope :ordered_by_team, -> { order(team_id: :asc) }
  scope :ordered_by_position, -> { order(position: :asc) }
  scope :ordered_by_sprint_and_position, -> { ordered_by_sprint.ordered_by_position }
  scope :ordered_by_team_and_position, -> { ordered_by_team.ordered_by_position }

  acts_as_list scope: [:sprint_id, :team_id], top_of_list: 0, add_new_at: :bottom

end
