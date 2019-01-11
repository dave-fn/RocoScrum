class Api::V1::EventResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  hide_id_with_hash_id
  immutable

  attributes :name, :timebox
  
  filter :name

end
