class ProjectPolicy < ApplicationPolicy

  def index?
    authenticated_user?
  end

  def show?
    owned_by_user?
  end

  def create?
    authenticated_user?
  end

  def update?
    owned_by_user?
  end

  def destroy?
    owned_by_user?
  end


  # Relationships
  def create_with_admin?(admin)
    user == admin
  end


  # Strong Parameters
  def permitted_attributes
    [:title, :description, :admin]
  end


  private

  def owned_by_user?
    record.admin == user
  end


  class Scope < Scope
    def resolve
      scope.where(admin: user)
    end
  end

end
