class ProductPolicy < ApplicationPolicy

  def index?
    authenticated_user?
  end

  def show?
    admin_user? || project_admin_by_user? || owned_by_user? || team_member?
  end

  def create?
    admin_user? || project_admin_by_user?
  end

  def update?
    admin_user? || project_admin_by_user? || owned_by_user?
  end

  def destroy?
    admin_user? || project_admin_by_user? || owned_by_user?
  end


  private

  def project_admin_by_user?
    record.project.admin == user
  end

  def owned_by_user?
    record.owner == user
  end

  def team_member?
    authenticated_user? && user.products.include?(record)
  end


  class Scope < Scope

    def resolve
      if user.nil?
        scope.none
      elsif user.admin?
        scope.all
      else
        s1 = scope.owned_by(user)
        s2 = scope.of_project_admin_by(user)
        s3 = scope.having_team_member(user)
        s1.or(s2).or(s3)
      end
    end

  end
end
