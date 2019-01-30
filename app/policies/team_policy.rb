class TeamPolicy < ApplicationPolicy

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
  # def create_with_admin?(admin)
  #   user == admin
  # end


  # Strong Parameters
  # def permitted_attributes
  #   []
  # end


  private

  def owned_by_user?
    record.project.admin == user
  end


  class Scope < Scope
    def resolve
      scope.joins(project: :admin).where(projects: {admin: user})
    end
  end

end
