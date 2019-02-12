# frozen_string_literal: true

class Event < ApplicationRecord

  include Hashid::Rails

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :timebox, presence: true, numericality: { greater_than_or_equal_to: 1 }

end
