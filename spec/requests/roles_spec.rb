# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Roles', type: :request do

  let(:url_base)  { '/api/roles' }

  let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1 }
  let(:unauthenticated_headers)  { api_header for_version: 1 }
  let(:user)  { create :user }


  describe 'GET /api/roles' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}?#{url_request_options}" }
    let(:url_request_options)  { '' }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let!(:product_owner_role)  { create(:product_owner_role) }
    let!(:developer_role)  { create(:developer_role) }

    it_behaves_like 'restricted index', authenticated: true, authenticated_count: 3, unauthenticated: true, unauthenticated_count: 3 do
      let(:example_request)  { request }
    end

    context 'when filtering' do
      context 'as authenticated user' do
        let(:request_headers)  { authenticated_headers }

        context 'by id' do
          let(:role_id)  { Role.last.id }
          let(:url_request_options)  { "filter[id]=#{role_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:role_hash_id)  { Role.last.hashid }
          let(:url_request_options)  { "filter[id]=#{role_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Developer' }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by description' do
          let(:url_request_options)  { 'filter[description]=9.99' }

          it_behaves_like 'bad request' do
            let(:example_request)  { request }
          end
        end
      end

      context 'as unauthenticated user' do
        let(:request_headers)  { unauthenticated_headers }

        context 'by id' do
          let(:role_id)  { Role.last.id }
          let(:url_request_options)  { "filter[id]=#{role_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:role_hash_id)  { Role.last.hashid }
          let(:url_request_options)  { "filter[id]=#{role_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Developer' }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by description' do
          let(:url_request_options)  { 'filter[description]=9.99' }

          it_behaves_like 'bad request' do
            let(:example_request)  { request }
          end
        end
      end
    end
  end


  describe 'GET /api/roles/:id' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}/#{role_id}" }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let!(:product_owner_role)  { create(:product_owner_role) }
    let!(:developer_role)  { create(:developer_role) }

    it_behaves_like 'restricted show', unauthenticated: true, authenticated: true do
      let(:available_resource_id)  { product_owner_role.hashid }
      let(:available_resource_url)  { "#{url_base}/#{available_resource_id}" }
      let(:unavailable_resource_url)  { "#{url_base}/0" }
    end
  end


  describe 'POST /api/roles' do
    let(:request)  { post url, headers: request_headers }
    let(:url)  { url_base }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end

    context 'as unauthenticated user' do
      let(:request_headers)  { unauthenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end
  end


  describe 'PUT /api/roles/:id' do
    let(:request)  { put url, params: resource_params, headers: request_headers }
    let(:url)  { "#{url_base}/#{role_id}" }
    let(:resource_params)  { {data: {type: 'roles', id: role.hashid, attributes: {max_participants: 2}}} }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let(:role)  { scrum_master_role }
    let(:role_id)  { role.hashid }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end

    context 'as unauthenticated user' do
      let(:request_headers)  { unauthenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end
  end


  describe 'DELETE /api/roles/:id' do
    let(:request)  { delete url, headers: request_headers }
    let(:url)  { "#{url_base}/#{role_id}" }

    let!(:scrum_master_role)  { create(:scrum_master_role) }
    let(:role)  { scrum_master_role }
    let(:role_id)  { role.hashid }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end

    context 'as unauthenticated user' do
      let(:request_headers)  { unauthenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end
  end

end
