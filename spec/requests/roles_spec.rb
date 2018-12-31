require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Roles', type: :request do

  # let(:api_header)  { api_header_for_version(1) }
  let(:api_header)  { generate_http_header version: 1 }


  describe 'GET /api/roles' do

    let(:base_url)  { '/api/roles' }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let!(:product_owner_role)  { create(:product_owner_role) }
    let!(:developer_role)  { create(:developer_role) }
    let(:user)  { create :dummy_user }
    
    it_behaves_like 'unrestricted index', '/api/roles', count: 3

    context 'when filtering' do
      context 'as unauthenticated user' do
        let(:rqst_opts)               { '' }
        let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: api_header }

        context 'by id' do
          let(:role_id)    { Role.last.id }
          let(:rqst_opts)  { "filter[id]=#{role_id}" }

          it_behaves_like 'accessible resource', count: 0 do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'by hash_id' do
          let(:role_hash_id)  { Role.last.hashid }
          let(:rqst_opts)     { "filter[id]=#{role_hash_id}" }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'by name' do
          let(:rqst_opts)  { 'filter[name]=Developer' }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'by description' do
          let(:rqst_opts)  { 'filter[description]=9.99' }

          it_behaves_like 'bad request' do
            let(:action)  { action_unauthenticated }
          end
        end
      end

      context 'as authenticated user' do
        let(:user)                  { create :user }
        # let(:auth_header)           { api_header.merge(authenticated_header(user)) }
        let(:auth_header)           { generate_http_header authenticate: user, version: 1 }
        let(:rqst_opts)             { '' }
        let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

        context 'by id' do
          let(:role_id)    { Role.last.id }
          let(:rqst_opts)  { "filter[id]=#{role_id}" }

          it_behaves_like 'accessible resource', count: 0 do
            let(:action)  { action_authenticated }
          end
        end

        context 'by hash_id' do
          let(:role_hash_id)  { Role.last.hashid }
          let(:rqst_opts)     { "filter[id]=#{role_hash_id}" }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_authenticated }
          end
        end

        context 'by name' do
          let(:rqst_opts)  { 'filter[name]=Developer' }

          it_behaves_like 'accessible resource', count: 1 do
            let(:action)  { action_authenticated }
          end
        end

        context 'by description' do
          let(:rqst_opts)  { 'filter[description]=Developer' }

          it_behaves_like 'bad request' do
            let(:action)  { action_authenticated }
          end
        end
      end
    end
  end


  describe 'GET /api/roles/:id' do
    let(:base_url)  { '/api/roles/:id' }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let!(:product_owner_role)  { create(:product_owner_role) }
    let!(:developer_role)  { create(:developer_role) }
    let(:roles)  { [scrum_master_role, product_owner_role, developer_role] }

    it_behaves_like 'unrestricted show', '/api/roles/:id' do
      let(:resource_id)  { roles.first.hashid }
    end
  end


  describe 'POST /api/roles' do
    let(:base_url)  { '/api/roles' }
    let(:action)    { post base_url, headers: api_header }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end


  describe 'PUT /api/roles/:id' do
    let(:base_url)  { '/api/roles/:id' }
    let(:action)    { put "#{base_url.sub(':id', role.hashid)}", params: resource_params.to_json, headers: api_header }
    let(:resource_params)  { {data: {type: 'roles', id: role.hashid, attributes: {max_participants: 2}}} }
    
    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let(:role)  { scrum_master_role }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end


  describe 'DELETE /api/roles/:id' do
    let(:base_url)  { '/api/roles/:id' }
    let(:action)    { delete "#{base_url.sub(':id', role.hashid)}", headers: api_header }
    
    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let(:role)  { scrum_master_role }

    specify { expect { action }.to raise_error ActionController::RoutingError }
  end

end
