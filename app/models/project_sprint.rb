# frozen_string_literal: true

class ProjectSprint < ApplicationRecord

  belongs_to :project, inverse_of: :project_sprints
  belongs_to :sprint, inverse_of: :project_sprint

end
