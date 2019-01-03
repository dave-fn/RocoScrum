class Api::V1::UserResource < Api::V1::ResourceBase

  hide_id_with_hash_id
  
  # Preliminary Implementation
  immutable

  attributes :name, :email, :last_logged_at
  
  filter :email

end
