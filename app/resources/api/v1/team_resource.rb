class Api::V1::TeamResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource

  key_by_hashid

  attributes :size
  attributes :scrum_master_id, :developers_id, :project_admin_id, :project_id # Preliminary Implementation

  # relationship :product_owner, to: :one
  relationship :scrum_master, to: :one
  relationship :developers, to: :many
  relationship :project, to: :one
  

  # Preliminary Implementation
  def scrum_master_id
    # puts "TEAM-RESOURCE::scrum_master_id, self=#{self.inspect}"
    return '' unless @model.scrum_master
    @model.scrum_master.hashid
  end

  def developers_id
    return '' unless @model.developers
    @model.developers.map(&:hashid)
  end

  def project_admin_id
    # puts "TEAM-RESOURCE::project_admin_id, self=#{self.inspect}"
    return '' unless @model.project
    @model.project.admin.hashid
  end

  def project_id
    # puts "TEAM-RESOURCE::project_id, self=#{self.inspect}"
    return '' unless @model.project
    @model.project.hashid
  end

end
