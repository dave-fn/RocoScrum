require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - Projects', type: :request do

  let(:url_base)  { '/api/projects' }

  let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1 }
  let(:unauthenticated_headers)  { api_header for_version: 1 }
  let(:user)  { create :user }
  let(:project_admin)  { user }


  describe 'GET /api/projects' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}?#{url_request_options}" }
    let(:url_request_options)  { '' }

    let!(:projects)  { create_list :project, 3, admin: project_admin, title: 'Test Project' }

    it_behaves_like 'restricted index', authenticated: true, unauthenticated: false, unauthenticated_count: 3 do
      let(:example_request)  { request }
    end

    context 'when filtering' do
      context 'as authenticated user' do
        let(:request_headers)  { authenticated_headers }

        context 'by id' do
          let(:project_id)  { Project.last.id }
          let(:url_request_options)  { "filter[id]=#{project_id}" }

          it_behaves_like 'accessible resource', expected_count: 0 do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:project_hash_id)  { Project.last.hashid }
          let(:url_request_options)  { "filter[id]=#{project_hash_id}" }

          it_behaves_like 'accessible resource', expected_count: 1 do
            let(:example_request)  { request }
          end
        end

        context 'by title' do
          let(:url_request_options)  { 'filter[title]=Test Project' }

          it_behaves_like 'accessible resource', expected_count: 3 do
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
          let(:project_id)  { Project.last.id }
          let(:url_request_options)  { "filter[id]=#{project_id}" }

          it_behaves_like 'unauthorized request' do
            let(:example_request)  { request }
          end
        end

        context 'by hash_id' do
          let(:project_hash_id)  { Project.last.hashid }
          let(:url_request_options)  { "filter[id]=#{project_hash_id}" }

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


  describe 'GET /api/projects/:id' do
    let(:request)  { get url, headers: request_headers }
    let(:url)  { "#{url_base}/#{project_id}" }

    let!(:projects)  { create_list :project, 3, admin: project_admin, title: 'Test Project' }
    let(:project)  { Project.last }
    let(:project_id)  { project.hashid }

    it_behaves_like 'restricted show', unauthenticated: false, authenticated: true do
      let(:available_resource_id)  { project_id }
      let(:available_resource_url)  { "#{url_base}/#{available_resource_id}" }
      let(:unavailable_resource_url)  { "#{url_base}/0" }
      let(:example_request)  { request }
    end
  end


  describe 'POST /api/projects' do
    let(:request)  { post url, headers: request_headers, params: resource_params }
    let(:url)  { url_base }

    let(:resource_params)  { project_params.to_json }
    let(:project_params)  { {data: {type: 'projects', attributes: project_attributes, relationships: project_relationships}} }
    let(:project_attributes)  { {title: 'Project Title'} }
    let(:project_relationships)  { {admin: {data: {type: 'users', id: user.hashid}}} }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }
      
      it_behaves_like 'creatable resource', fields: {name: 'title', value: 'Project Title'} do
        let(:example_request)  { request }
      end

      specify { expect { request }.to change { Project.count }.by 1 }
    end
  end


  describe 'PUT /api/projects/:id' do
    let(:request)  { put url, headers: request_headers, params: resource_params }
    let(:url)  { "#{url_base}/#{project_id}" }  

    let(:resource_params)  { project_params.to_json }
    let(:project_params)  { {data: {type: 'projects', id: project_id, attributes: project_attributes}} }
    let(:project_attributes)  { {title: 'New Title'} }
    
    let!(:projects)  { create_list :project, 3, admin: project_admin, title: 'Test Project' }
    let(:project)  { Project.last }
    let(:project_id)  { project.hashid }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }

      it_behaves_like 'updatable resource', fields: {name: 'title', value: 'New Title'} do
        let(:example_request)  { request }
        let(:resource_id)  { project_id }
      end
    end
  end


  describe 'DELETE /api/projects/:id' do
    let(:request)  { delete url, headers: request_headers }
    let(:url)  { "#{url_base}/#{project_id}" }
    
    let!(:projects)  { create_list :project, 3, admin: project_admin, title: 'Test Project' }
    let(:project)  { Project.last }
    let(:project_id)  { project.hashid }

    # OVERRIDE
    let(:authenticated_headers)  { api_header authenticate_as: user, for_version: 1, content_type: 'application/vnd.api+json' }

    context 'as authenticated user' do
      let(:request_headers)  { authenticated_headers }

      context 'as authorized user' do
        it_behaves_like 'deletable resource' do
          let(:example_request)  { request }
        end

        specify { expect { request }.to change { Project.count }.by -1 }
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
