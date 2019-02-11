class Api::V1::TeamResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource

  key_by_hashid

  attributes :size

  # relationship :product_owner, to: :one
  relationship :scrum_master, to: :one
  relationship :developers, to: :many
  relationship :project, to: :one

  def self.creatable_fields(context)
    super - [:size]
  end

  def self.updatable_fields(context)
    creatable_fields(context)
  end

end
