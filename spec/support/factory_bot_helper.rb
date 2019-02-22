# frozen_string_literal: true

module FactoryBotHelper

  class << self

    def roles_factories
      _each_factories(_roles_factories)
    end

    def sprint_backlog_item_statuses_factories
      _each_factories(_sbi_statuses_factories)
    end

    private

    def _each_factories(factories)
      factories.each { |factory| yield(factory) } if block_given?
      factories
    end

    def _roles_factories
      [:scrum_master_role, :developer_role, :product_owner_role]
    end

    def _sbi_statuses_factories
      [:sbi_committed_status, :sbi_assigned_status, :sbi_in_progress_status, :sbi_completed_status, :sbi_pending_status]
    end

  end

end
