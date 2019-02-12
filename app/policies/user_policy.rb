# frozen_string_literal: true

class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    self? || admin_user?
  end

  def show?
    true
  end


  private

  def self?
    user == record
  end


  class Scope < Scope

    def resolve
      scope.all
    end

  end

end
