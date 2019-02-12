# frozen_string_literal: true

class Api::V1::EventResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource

  key_by_hashid

  immutable

  attributes :name, :timebox

  filter :name

  def timebox
    t = @model.timebox
    tvalues = [t / 86_400, t / 3_600 % 24, t / 60 % 60, t % 60]
    return ActiveSupport::Duration.new(nil, month: 1).inspect if tvalues[0] >= 30
    duration_values = { days: tvalues[0], hours: tvalues[1], minutes: tvalues[2], seconds: tvalues[3] }
    ActiveSupport::Duration.new(nil, duration_values).inspect
  end

end
