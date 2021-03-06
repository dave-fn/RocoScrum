# frozen_string_literal: true

class ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Helper Methods
  def authenticated_user?
    !unauthenticated_user?
  end

  def unauthenticated_user?
    user.nil?
  end

  def admin_user?
    authenticated_user? && user.admin?
  end

  # Strong Parameters
  # def permitted_attributes
  # end


  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

  end

end
