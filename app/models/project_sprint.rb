# frozen_string_literal: true

class ProjectSprint < ApplicationRecord

  belongs_to :project, inverse_of: :project_sprints
  belongs_to :sprint, inverse_of: :project_sprint

  validates :project_id, uniqueness: { scope: [:sprint_id] }
  validates :sprint_id, uniqueness: { scope: [:project_id] }

  validates :position, uniqueness: { scope: [:project_id] }, numericality: { only_integer: true }

end
