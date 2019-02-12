# frozen_string_literal: true

class Api::V1::RoleResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource

  key_by_hashid

  immutable

  attributes :name, :description, :min_participants, :max_participants

  filter :name

end
