class Api::V1::UserResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  hide_id_with_hash_id
  
  # Preliminary Implementation
  immutable

  attributes :name, :email, :last_logged_at, :admin?
  
  filter :email

end
