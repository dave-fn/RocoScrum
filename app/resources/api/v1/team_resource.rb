class Api::V1::TeamResource < JSONAPI::Resource

  include JSONAPI::Authorization::PunditScopedResource

  attributes :size, :scrum_master_id, :developers_id, :project_admin_id, :project_id

  # relationship :product_owner, to: :one
  relationship :scrum_master, to: :one
  # relationship :developers, to: :many
  relationship :project, to: :one
  

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


  key_type :string

  def self.find_by_key(key, options = {})
    # puts "TEAM-RESOURCE find_by_key, key=#{key}, opts=#{options}"
    context = options[:context]
    begin
      model = _model_class.find(key)
    rescue ActiveRecord::RecordNotFound
      fail JSONAPI::Exceptions::RecordNotFound.new(key)
    end
    self.resource_for_model(model).new(model, context)
  end

  def self.verify_key(key, context = nil)
    # puts "TEAM-RESOURCE verify_key, key=#{key}, context=#{context}"
    # x = super
    # puts "result = #{x}, but could be=#{_model_class.decode_id(key)}"
    # x
    # puts "result = #{_model_class.decode_id key}"
    _model_class.decode_id key
  end

  filter :id,
    verify: :verify_keys,
    apply: -> (records, value, options) do
      # puts "TEAM-RESOURCE verify :id, value=#{value}"
      # records.where(id: _model_class.decode_id(value))
      records.where(id: value)
    end

  def id
    # puts "TEAM-RESOURCE id, self=#{self.inspect}"
    return '' if @model.id == nil
    @model.hashid
  end

end
