# frozen_string_literal: true

class BacklogItem < ApplicationRecord

  include Hashid::Rails

  validates :title, presence: true, length: { minimum: 3 }

end
