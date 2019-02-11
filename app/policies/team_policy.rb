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


  private

  def owned_by_user?
    record.project.admin == user
  end


  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        # scope.joins(project: :admin).where(projects: {admin: user})
        # scope.joins(project: :admin).merge(Project.admin_by user)
        scope.joins(:project).merge(Project.admin_by user)
      end
    end
  end

end
