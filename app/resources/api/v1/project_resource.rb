class Api::V1::ProjectResource < Api::V1::ResourceBase


  include JSONAPI::Authorization::PunditScopedResource
  
  # hide_id_with_hash_id

  attributes :title, :description
  has_one :admin, class_name: 'User'
  
  filter :title

  key_type :string

  def self.find_by_key(key, options = {})
    context = options[:context]
    begin
      model = _model_class.find(key)
    rescue ActiveRecord::RecordNotFound
      fail JSONAPI::Exceptions::RecordNotFound.new(key)
    end
    self.resource_for_model(model).new(model, context)
  end

  def id
    return '' if @model.id == nil
    @model.hashid
  end

  filter :id,
    verify: :verify_keys,
    apply: -> (records, value, options) { records.where id: _model_class.decode_id(value) }
    
  def replace_to_one_link(r_type, r_value, options = {})
    # puts "replace_to_one_link, project, type=#{r_type}, value=#{r_value}"
    # @model.admin_id = relationship_class(r_type).decode_id(r_value)
    super
  end


  private

  def relationship_class(relationship)
    self.class._relationship(relationship).options[:class_name].constantize
  end

end
