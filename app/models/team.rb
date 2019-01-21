class Team < ApplicationRecord

  include Hashid::Rails

  belongs_to :project, inverse_of: :teams

end
