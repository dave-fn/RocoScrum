# frozen_string_literal: true

class Sprint < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  has_many :sprint_backlog_items, dependent: :destroy, inverse_of: :sprint

  def started?
    started_at != nil
  end

end
