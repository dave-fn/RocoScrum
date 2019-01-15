class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end


  # Strong Parameters
  def permitted_attributes
    [:name, :email, :password, :password_confirmation, :projects]
  end

  
  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
