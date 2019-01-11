class Api::V1::EventResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  hide_id_with_hash_id
  immutable

  attributes :name, :timebox
  
  filter :name

  def timebox
    t = @model.timebox
    tvalues = [t/86400, t/3600%24, t/60%60, t%60]
    return ActiveSupport::Duration.new(nil, month: 1).inspect if tvalues[0] >= 30
    ActiveSupport::Duration.new(nil, days: tvalues[0], hours: tvalues[1], minutes: tvalues[2], seconds: tvalues[3]).inspect
  end

end
