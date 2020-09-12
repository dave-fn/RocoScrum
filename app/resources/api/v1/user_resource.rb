# frozen_string_literal: true

class Api::V1::UserResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource

  key_by_hashid

  # Preliminary Implementation
  immutable

  attributes :name, :email, :last_logged_at, :admin?, :developer?, :scrum_master?, :product_owner?, :project_admin?

  filter :email

  def self.creatable_fields(_context)
    [:name, :email, :password, :password_confirmation]
  end

  def self.updatable_fields(context)
    if context[context_user_key].admin?
      [:name]
    else
      [:name, :password, :password_confirmation]
    end
  end

end
