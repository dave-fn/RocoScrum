# frozen_string_literal: true

module FactoryBotHelper

  class << self

    def roles_factories
      roles = _roles_factories
      roles.each { |factory| yield(factory) } if block_given?
      roles
    end

    private

    def _roles_factories
      [:scrum_master_role, :developer_role, :product_owner_role]
    end

  end

end
