require 'api_constraint'

Rails.application.routes.draw do

  namespace :api do
    post 'user_token' => 'user_token#create'
    scope module: :v1, constraints: ApiConstraint.new(version: 1, default: false) do
      jsonapi_resources :roles do
      end
    end
  end
  
end
