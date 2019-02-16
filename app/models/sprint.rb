# frozen_string_literal: true

class Sprint < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  has_many :sprint_backlog_items, dependent: :destroy, inverse_of: :sprint
  has_many :backlog_items, through: :sprint_backlog_items

  has_one :project_sprint, dependent: :destroy, inverse_of: :sprint
  has_one :project, through: :project_sprint

  def started?
    started_at != nil
  end

end
