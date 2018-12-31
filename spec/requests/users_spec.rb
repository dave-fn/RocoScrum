require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Users', type: :request do

  let(:api_header)  { api_header_for_version 1 }


  describe 'GET /api/users' do

    let(:base_url)  { '/api/users' }

    let!(:user)   { create :dummy_user, name: 'testuser' }
    let!(:users)  { create_list :dummy_user, 3 }

    it_behaves_like 'restricted index', '/api/users', count: 4

    context 'when filtering' do
      context 'as unauthenticated user' do
        let(:rqst_opts)               { '' }
        let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: api_header }

        context 'by id' do
          let(:user_id)    { User.last.id }
          let(:rqst_opts)  { "filter[id]=#{user_id}" }

          it_behaves_like 'unauthorized request' do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'by hash_id' do
          let(:user_hash_id)  { User.last.hashid }
          let(:rqst_opts)     { "filter[id]=#{user_hash_id}" }

          it_behaves_like 'unauthorized request' do
            let(:action)  { action_unauthenticated }
          end
        end

        xcontext 'by email' do
          let(:rqst_opts)  { 'filter[email]=Developer' }

          it_behaves_like 'unauthorized request' do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'by name' do
          let(:rqst_opts)  { 'filter[name]=9.99' }

          it_behaves_like 'unauthorized request' do
            let(:action)  { action_unauthenticated }
          end
        end
      end

      context 'as authenticated user' do
        let(:user)                  { create :user }
        let(:auth_header)           { api_header.merge(authenticated_header(user)) }
        let(:rqst_opts)             { '' }
        let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

        context 'by id' do
          let(:user_id)    { User.last.id }
          let(:rqst_opts)  { "filter[id]=#{user_id}" }

          it_behaves_like 'accessible resource', count: 0 do
            let(:action)  { action_authenticated }
          end
        end

        context 'by hash_id' do
          let(:user_hash_id)  { User.last.hashid }
          let(:rqst_opts)     { "filter[id]=#{user_hash_id}" }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_authenticated }
          end
        end

        xcontext 'by email' do
          let(:rqst_opts)  { 'filter[email]=Developer' }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_authenticated }
          end
        end

        context 'by name' do
          let(:rqst_opts)  { 'filter[name]=Developer' }

          it_behaves_like 'bad request' do
            let(:action)  { action_authenticated }
          end
        end
      end
    end
  end


  describe 'GET /api/users/:id' do
    let(:base_url)  { '/api/users/:id' }

    let(:user)  { create :dummy_user }

    it_behaves_like 'restricted show', '/api/users/:id' do
      let(:resource_id)  { user.hashid }
    end
  end


  # Preliminary Implementation - Will need to provide mechanism to create users
  describe 'POST /api/users' do
    let(:base_url)  { '/api/users' }
    let(:action)    { post base_url, headers: api_header }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end


  # Preliminary Implementation - Will need to provide mechanism to update users
  describe 'PUT /api/users/:id' do
    let(:base_url)  { '/api/users/:id' }
    let(:action)    { put "#{base_url.sub(':id', user.hashid)}", params: resource_params.to_json, headers: api_header }
    let(:resource_params)  { {data: {type: 'users', id: user.hashid, attributes: {email: 'test@example.org'}}} }
    
    let!(:user)  { create :dummy_user }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end


  # Preliminary Implementation - Will need to provide mechanism to delete users
  describe 'DELETE /api/users/:id' do
    let(:base_url)  { '/api/users/:id' }
    let(:action)    { delete "#{base_url.sub(':id', user.hashid)}", headers: api_header }
    
    let!(:user)  { create :dummy_user }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end

end
