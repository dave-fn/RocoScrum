# frozen_string_literal: true

class Admin < ApplicationRecord

  belongs_to :user, inverse_of: :admin

end
