class Api::V1::ProjectResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  key_by_hashid

  attributes :title, :description
  relationship :admin, to: :one, class_name: 'User'
  
  filter :title

end
