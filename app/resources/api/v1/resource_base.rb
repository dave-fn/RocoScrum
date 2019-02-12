# frozen_string_literal: true

class Api::V1::ResourceBase < JSONAPI::Resource

  abstract

  module Constants

    CONTEXT_USER_KEY = :key
    DEFAULT_HASHID = ''

  end

  def self.key_by_hashid # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    key_type :string

    filter :id,
           verify: :verify_keys,
           apply: ->(records, value, _options) do
             records.where(id: value)
           end

    # rubocop:disable Lint/NestedMethodDefinition
    def self.find_by_key(key, options = {})
      begin
        model = _model_class.find(key)
      rescue ActiveRecord::RecordNotFound
        raise JSONAPI::Exceptions::RecordNotFound.new(key) # rubocop:disable Style/RaiseArgs
      end
      resource_for_model(model).new(model, options[:context])
    end

    def self.verify_key(key, _context = nil)
      _model_class.decode_id(key)
    end

    def default_hashid
      Constants::DEFAULT_HASHID
    end

    def id
      return default_hashid if @model.id.nil?
      @model.hashid
    end
    # rubocop:enable Lint/NestedMethodDefinition
  end

  def self.context_user_key
    Constants::CONTEXT_USER_KEY
  end

end
