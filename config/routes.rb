require 'api_constraint'

Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  namespace :api do
    scope module: :v1, constraints: ApiConstraint.new(version: 1, default: false) do
    end
  end
end
