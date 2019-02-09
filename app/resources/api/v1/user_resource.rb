class Api::V1::UserResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  key_by_hashid
  
  # Preliminary Implementation
  immutable

  attributes :name, :email, :last_logged_at, :admin?
  
  filter :email

end
