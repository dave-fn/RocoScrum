# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Users', type: :request do

  let(:url_base)  { '/api/users' }

  let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1 }
  let(:unauthenticated_headers)  { api_header for_version: 1 }
  let(:user)  { create :user }
  let(:user_id)  { user.hashid }


  describe 'GET /api/users' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}?#{url_request_options}" }
    let(:url_request_options)  { '' }

    let!(:user)   { create :user, name: 'testuser' }
    let!(:users)  { create_list :user, 3 }

    it_behaves_like 'restricted index', authenticated: {count: 4}, unauthenticated: false do
      let(:example_request)  { request }
    end

    context 'when filtering' do
      context 'as authenticated user' do
        let(:request_headers)  { authenticated_headers }

        context 'by id' do
          let(:user_id)    { User.last.id }
          let(:url_request_options)  { "filter[id]=#{user_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:user_hash_id)  { User.last.hashid }
          let(:url_request_options)  { "filter[id]=#{user_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by email' do
          let(:user_email)  { User.last.email }
          let(:url_request_options)  { "filter[email]=#{user_email}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Developer' }

          it_behaves_like 'bad request' do
            let(:example_request)  { request }
          end
        end
      end

      context 'as unauthenticated user' do
        let(:request_headers)  { unauthenticated_headers }

        context 'by hash_id' do
          let(:user_hash_id)  { User.last.hashid }
          let(:rqst_opts)     { "filter[id]=#{user_hash_id}" }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end
      end
    end
  end


  describe 'GET /api/users/:id' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}/#{user_id}" }

    it_behaves_like 'restricted show', unauthenticated: false, authenticated: true do
      let(:available_resource_id)  { user.hashid }
      let(:available_resource_url)  { "#{url_base}/#{available_resource_id}" }
      let(:unavailable_resource_url)  { "#{url_base}/#{user.id}" }
      let(:example_request)  { request }
    end
  end


  # Preliminary Implementation - Will need to provide mechanism to create users
  describe 'POST /api/users' do
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


  # Preliminary Implementation - Will need to provide mechanism to update users
  describe 'PUT /api/users/:id' do
    let(:request)  { put url, params: resource_params, headers: request_headers }
    let(:url)  { "#{url_base}/#{user_id}" }
    let(:resource_params)  { {data: {type: 'users', id: user.hashid, attributes: {email: 'test@example.org'}}} }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end

    context 'as unauthenticated user' do
      let(:request_headers)  { unauthenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end
  end


  # Preliminary Implementation - Will need to provide mechanism to delete users
  describe 'DELETE /api/users/:id' do
    let(:request)  { delete url, headers: request_headers }
    let(:url)  { "#{url_base}/#{user_id}" }

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
