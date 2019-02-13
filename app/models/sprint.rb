# frozen_string_literal: true

class Sprint < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

  def started?
    started_at != nil
  end

end
