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


  # Relationships - Admin
  def create_with_admin?(admin)
    user == admin || admin_user?
  end

  def replace_admin?(admin)
    admin_user?
  end

  def remove_admin?(admin)
    false
  end

  # Relationships - Teams
  def add_to_teams?(teams)
    owned_by_user? || admin_user?
  end

  def remove_from_teams?(teams)
    owned_by_user? || admin_user?
  end

  def replace_teams?(teams)
    owned_by_user? || admin_user?
  end

  # def create_with_teams?(teams)
  # end


  private

  def owned_by_user?
    record.admin == user
  end


  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.admin_by(user)
      end
    end
  end

end
