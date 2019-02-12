# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Events', type: :request do

  let(:url_base)  { '/api/events' }

  let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1 }
  let(:unauthenticated_headers)  { api_header for_version: 1 }
  let(:user)  { create :user }


  describe 'GET /api/events' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}?#{url_request_options}" }
    let(:url_request_options)  { '' }

    let!(:sprint_event)  { create(:sprint_event) }
    let!(:sprint_planning_event)  { create(:sprint_planning_event) }
    let!(:daily_scrum_event)  { create(:daily_scrum_event) }

    it_behaves_like 'restricted index', authenticated: {count: 3}, unauthenticated: {count: 3} do
      let(:example_request)  { request }
    end

    context 'when filtering' do
      context 'as authenticated user' do
        let(:request_headers)  { authenticated_headers }

        context 'by id' do
          let(:event_id)  { Event.last.id }
          let(:url_request_options)  { "filter[id]=#{event_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:event_hash_id)  { Event.last.hashid }
          let(:url_request_options)  { "filter[id]=#{event_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Sprint' }

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
          let(:event_id)  { Event.last.id }
          let(:url_request_options)  { "filter[id]=#{event_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:event_hash_id)  { Event.last.hashid }
          let(:url_request_options)  { "filter[id]=#{event_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Sprint' }

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


  describe 'GET /api/events/:id' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}/#{event_id}" }

    let!(:sprint_event)  { create(:sprint_event) }
    let!(:sprint_planning_event)  { create(:sprint_planning_event) }
    let!(:daily_scrum_event)  { create(:daily_scrum_event) }

    it_behaves_like 'restricted show', unauthenticated: true, authenticated: true do
      let(:available_resource_id)  { sprint_planning_event.hashid }
      let(:available_resource_url)  { "#{url_base}/#{available_resource_id}" }
      let(:unavailable_resource_url)  { "#{url_base}/0" }
    end
  end


  describe 'POST /api/events' do
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


  describe 'PUT /api/events/:id' do
    let(:request)  { put url, params: resource_params, headers: request_headers }
    let(:url)  { "#{url_base}/#{event_id}" }
    let(:resource_params)  { {data: {type: 'events', id: event.hashid, attributes: {max_participants: 2}}} }

    let!(:sprint_event)  { create(:sprint_event) }
    let(:event)  { sprint_event }
    let(:event_id)  { event.hashid }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end

    context 'as unauthenticated user' do
      let(:request_headers)  { unauthenticated_headers }
      specify { expect { request }.to raise_error ActionController::RoutingError }
    end
  end


  describe 'DELETE /api/events/:id' do
    let(:request)  { delete url, headers: request_headers }
    let(:url)  { "#{url_base}/#{event_id}" }

    let!(:sprint_event)  { create(:sprint_event) }
    let(:event)  { sprint_event }
    let(:event_id)  { event.hashid }

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
