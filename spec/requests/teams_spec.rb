require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Teams', type: :request do

  let(:url_base)  { '/api/teams' }

  let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1 }
  let(:unauthenticated_headers)  { api_header for_version: 1 }
  let(:user)  { create :user }
  let(:project_admin)  { user }


  describe 'GET /api/teams' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}?#{url_request_options}" }
    let(:url_request_options)  { '' }

    let!(:user_team)  { create :working_team, project:(create :project, admin: user) }
    let!(:teams)  { create_list :working_team, 3 }

    it_behaves_like 'restricted index', authenticated: true, unauthenticated: false, unauthenticated_count: 3 do
      let(:example_request)  { request }
    end

    context 'when filtering' do
      context 'as authenticated user' do
        let(:request_headers)  { authenticated_headers }

        context 'by id' do
          let(:team_id)  { user_team.id }
          let(:url_request_options)  { "filter[id]=#{team_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:team_hash_id)  { user_team.hashid }
          let(:url_request_options)  { "filter[id]=#{team_hash_id}" }

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
          let(:team_id)  { Team.last.id }
          let(:url_request_options)  { "filter[id]=#{team_id}" }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:team_hash_id)  { Team.last.hashid }
          let(:url_request_options)  { "filter[id]=#{team_hash_id}" }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end

        context 'by name' do
          let(:url_request_options)  { 'filter[name]=Sprint' }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end

        context 'by description' do
          let(:url_request_options)  { 'filter[description]=9.99' }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end
      end
    end
  end


  describe 'GET /api/teams/:id' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}/#{team_id}" }

    let(:user_team)  { create :working_team, project:(create :project, admin: user) }
    let(:team_id)  { user_team.hashid }

    it_behaves_like 'restricted show', unauthenticated: false, authenticated: true do
      let(:available_resource_id)  { team_id }
      let(:available_resource_url)  { "#{url_base}/#{available_resource_id}" }
      let(:unavailable_resource_url)  { "#{url_base}/0" }
      let(:example_request)  { request }
    end
  end


  describe 'POST /api/teams' do
    let(:request)  { post url, headers: request_headers, params: resource_params }
    let(:url)  { url_base }

    let(:resource_params)  { team_params.to_json }
    let(:team_params)  { {data: {type: 'teams', attributes: team_attributes, relationships: team_relationships}} }
    let(:team_attributes)  { attributes_for :working_team }
    let(:project)  { create :project, admin: user }
    let(:team_relationships)  { {project: {data: {type: 'projects', id: project.hashid}}} }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      
      it_behaves_like 'creatable resource' do
        let(:example_request)  { request }
      end

      it 'creates relationship' do
        request
        expect(json_response.dig('data', 'relationships')).to have_key 'project'
      end

      specify { expect { request }.to change { Team.count }.by 1 }
    end
  end


  describe 'PUT /api/teams/:id' do
    let(:request)  { put url, headers: request_headers, params: resource_params }
    let(:url)  { "#{url_base}/#{team_id}" }  

    let(:resource_params)  { team_params.to_json }
    let(:team_params)  { {data: {type: 'teams', id: team_id, relationships: team_relationships}} }
    let(:project)  { create :project, admin: user }
    let(:team_relationships)  { {project: {data: {type: 'projects', id: project.hashid}}} }
    
    let!(:teams)  { create_list :working_team, 3, project:(create :project, admin: user) }
    let(:team)  { teams.last }
    let(:team_id)  { team.hashid }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }

      it_behaves_like 'updatable resource' do
        let(:example_request)  { request }
        let(:resource_id)  { team_id }
      end
    end
  end


  describe 'DELETE /api/teams/:id' do
    let(:request)  { delete url, headers: request_headers }
    let(:url)  { "#{url_base}/#{team_id}" }
    
    let!(:teams)  { create_list :working_team, 3, project:(create :project, admin: project_admin) }
    let(:team)  { teams.last }
    let(:team_id)  { team.hashid }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }

      context 'as authorized user' do
        it_behaves_like 'deletable resource' do
          let(:example_request)  { request }
        end

        specify { expect { request }.to change { Team.count }.by -1 }
      end

      context 'as unauthorized user' do
        let(:project_admin)  { create :user }

        it_behaves_like 'forbidden request' do
          let(:example_request)  { request }
        end
      end
    end
  end

end
