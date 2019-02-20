# frozen_string_literal: true

class ProjectSprint < ApplicationRecord

  validates :project_id, uniqueness: { scope: [:sprint_id] }
  validates :sprint_id, uniqueness: { scope: [:project_id] }
  # validates :position, uniqueness: { scope: [:project_id] }, numericality: { only_integer: true }, allow_nil: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  # Association
  belongs_to :project, inverse_of: :project_sprints
  belongs_to :sprint, inverse_of: :project_sprint

  # Scopes
  scope :ordered_by_position, -> { order(position: :asc) }

  acts_as_list scope: :project, top_of_list: 0, add_new_at: :bottom

end
