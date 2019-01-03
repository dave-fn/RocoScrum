class Api::V1::RoleResource < Api::V1::ResourceBase

  hide_id_with_hash_id
  immutable

  attributes :name, :description, :min_participants, :max_participants
  
  filter :name

end
