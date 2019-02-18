# frozen_string_literal: true

class Sprint < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  has_many :sprint_backlog_items, dependent: :destroy, inverse_of: :sprint
  has_many :backlog_items, through: :sprint_backlog_items

  has_one :project_sprint, dependent: :destroy, inverse_of: :sprint
  has_one :project, through: :project_sprint

  scope :ordered_by_start, -> { order(started_at: :asc) }

  def started?
    started_at != nil
  end

  def start!
    update!(started_at: Time.now.utc)
  end

end
