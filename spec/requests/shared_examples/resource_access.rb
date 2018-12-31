# shared_examples 'unrestricted index' do |url, opts = {}|
#   # require_let_definitions :req_header

#   # let(:base_url)  { url }

#   context 'as unauthenticated user' do
#     # let(:rqst_opts)               { '' }
#     # let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: req_header }

#     it_behaves_like 'accessible resource', expected_count: opts[:count] do
#       # let(:action)  { action_unauthenticated }
#       # let(:example_request)  { action_unauthenticated }
#     end
#   end

#   context 'as authenticated user' do
#     # require_let_definitions :user
#     # let(:user)                  { create :user }
#     # let(:auth_header)           { req_header.merge(authenticated_header(user)) }
#     # let(:rqst_opts)             { '' }
#     # let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

#     it_behaves_like 'accessible resource', expected_count: opts[:count] do
#       # let(:action)  { action_authenticated }
#       # let(:example_request)  { action_unauthenticated }
#     end
#   end
# end


shared_examples 'restricted index' do |url, opts = {}|
  require_let_definitions :req_header

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:rqst_opts)               { '' }
    let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: req_header }

    it_behaves_like 'unauthorized request', expected_count: opts[:count] do
      let(:action)  { action_unauthenticated }
    end
  end

  context 'as authenticated user' do
    require_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { req_header.merge(authenticated_header(user)) }
    let(:rqst_opts)             { '' }
    let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

    it_behaves_like 'accessible resource', expected_count: opts[:count] do
      let(:action)  { action_authenticated }
    end
  end
end


shared_examples 'unrestricted show' do |url, opts = {}|
  require_let_definitions :resource_id, :req_header

  let(:base_url)  { url }

  let(:action_unauthenticated)  { get "#{base_url.sub(':id', resource_id.to_s)}", headers: req_header }

  context 'when resource exists' do
    it_behaves_like 'accessible resource' do
      let(:action)  { action_unauthenticated }
    end

    it 'returns a single instance' do
      action_unauthenticated
      expect(json_response.dig('data', 'id')).to eq(resource_id.to_s)
    end
  end

  context 'when resource does not exist' do
    let(:resource_id)  { -1 }

    it_behaves_like 'missing resource' do
      let(:example_request)  { action_unauthenticated }
    end
  end
end


shared_examples 'accessible show actions' do
  let(:url)  { "#{url_base}/#{resource_id}" }
  let(:example_request)  { get url, headers: request_headers }

  context 'when resource exists' do
    let(:resource_id)  { available_resource_id }

    it_behaves_like 'accessible resource'
    it 'returns a single instance' do
      example_request
      expect(json_response.dig('data', 'id')).to eq(resource_id.to_s)
    end
  end

  context 'when resource does not exist' do
    let(:resource_id)  { unavailable_resource_id }
    it_behaves_like 'missing resource'
  end
end


shared_examples 'restricted show' do |url, opts = {}|
  require_let_definitions :req_header

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:rqst_opts)               { '' }
    let(:action_unauthenticated)  { get "#{base_url.sub(':id', resource_id.to_s)}", headers: req_header }

    it_behaves_like 'unauthorized request', expected_count: opts[:count] do
      let(:action)  { action_unauthenticated }
    end
  end

  context 'as authenticated user' do
    require_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { req_header.merge(authenticated_header(user)) }
    let(:rqst_opts)             { '' }
    let(:action_authenticated)  { get "#{base_url.sub(':id', resource_id.to_s)}", headers: auth_header }

    context 'when resource exists' do
      it_behaves_like 'accessible resource' do
        let(:action)  { action_authenticated }
      end

      it 'returns a single instance' do
        action_authenticated
        expect(json_response.dig('data', 'id')).to eq(resource_id.to_s)
      end
    end

    context 'when resource does not exist' do
      let(:resource_id)  { -1 }

      it_behaves_like 'missing resource' do
        let(:action)  { action_authenticated }
      end
    end
  end
end


shared_examples 'restricted create' do |url, update_params, opts = {}|
  require_let_definitions :req_header, :resource_params, :invalid_params, :missing_params

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:action_unauthenticated)  { post base_url, params: resource_params.to_json, headers: req_header }

    context 'missing Content-Type' do  
      let(:req_header)  { {'Content-Type': 'application/vnd.json'} }

      it_behaves_like 'bad content type' do
        let(:action)  { action_unauthenticated }
      end
    end

    context 'given correct Content-Type' do
      context 'given valid parameters' do
        it_behaves_like 'forbidden request' do
          let(:action)  { action_unauthenticated }
        end
      end

      context 'given invalid parameters' do
        let(:resource_params)  { invalid_params }

        it_behaves_like 'bad request' do
          let(:action)  { action_unauthenticated }
        end
      end

      context 'missing parameters' do
        let(:resource_params)  { missing_params }

        it_behaves_like 'forbidden request' do
          let(:action)  { action_unauthenticated }
        end
      end
    end
  end

  context 'as authenticated user' do
    require_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { req_header.merge(authenticated_header(user)) }
    let(:rqst_headers)          { req_header.merge auth_header }
    let(:action_authenticated)  { post base_url, params: resource_params.to_json, headers: rqst_headers }

    context 'missing Content-Type'do  
      let(:req_header)  { {'Content-Type': 'application/vnd.json'} }

      it_behaves_like 'bad content type' do
        let(:action)  { action_authenticated }
      end
    end

    context 'given correct Content-Type' do
      context 'given valid parameters' do
        it_behaves_like 'creatable resource', fields: update_params do
          let(:action)  { action_authenticated }
        end
      end

      context 'given invalid parameters' do
        let(:resource_params)  { invalid_params }

        it_behaves_like 'bad request' do
          let(:action)  { action_authenticated }
        end
      end

      context 'missing parameters' do
        let(:resource_params)  { missing_params }

        it_behaves_like 'unprocessable entity request' do
          let(:action)  { action_authenticated }
        end
      end
    end
  end
end


shared_examples 'restricted update' do |url, opts = {}|
  require_let_definitions :content_header, :resource_id, :resource_params, :invalid_params

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:action_unauthenticated)  { put "#{base_url.sub(':id', resource_id.to_s)}", params: resource_params.to_json, headers: content_header }

    context 'missing Content-Type' do
      let(:content_header)  { {'Content-Type': 'application/vnd.json'} }

      it_behaves_like 'bad content type' do
        let(:action)  { action_unauthenticated }
      end
    end

    context 'given correct Content-Type' do
      context 'when record exists' do
        context 'given valid parameters' do
          it_behaves_like 'forbidden request' do
            let(:action)  { action_unauthenticated }
          end
        end

        context 'given invalid parameters' do
          let(:resource_params)  { invalid_params }

          it_behaves_like 'bad request' do
            let(:action)  { action_unauthenticated }
          end
        end
      end

      context 'when record does not exist' do
        let(:resource_id)  { -1 }

        it_behaves_like 'missing resource' do
          let(:action)  { action_unauthenticated }
        end
      end
    end
  end

  context 'as authenticated user' do
    require_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { req_header.merge(authenticated_header(user)) }
    let(:rqst_headers)          { content_header.merge auth_header }
    let(:action_authenticated)  { put "#{base_url.sub(':id', resource_id.to_s)}", params: resource_params.to_json, headers: rqst_headers }

    context 'missing Content-Type' do
      let(:content_header)  { {'Content-Type': 'application/vnd.json'} }

      it_behaves_like 'bad content type' do
        let(:action)  { action_authenticated }
      end
    end

    context 'given correct Content-Type' do
      context 'when record exists' do
        context 'given valid parameters' do
          it_behaves_like 'updatable resource' do
            let(:id)      { resource_id.to_s }
            let(:action)  { action_authenticated }
          end
        end

        context 'given invalid parameters' do
          let(:resource_params)  { invalid_params }

          it_behaves_like 'bad request' do
            let(:action)  { action_authenticated }
          end
        end
      end

      context 'when record does not exist' do
        let(:resource_id)  { -1 }

        it_behaves_like 'missing resource' do
          let(:action)  { action_authenticated }
        end
      end
    end
  end
end


shared_examples 'accessible resource' do |expected_count: nil|
  before { example_request }

  specify { expect(response).to have_http_status :ok }

  if expected_count then
    it_message = if expected_count == 1 then 'returns list with single result'
    elsif expected_count == 0 then 'returns empty results list'
    else 'returns list of results'
    end

    it it_message do
      expect(json_response['data'].length).to eq expected_count
    end

    # if expected_count == 1 then
    #   it 'returns a single result' do
    #     puts "the data is = #{json_response['data']}"
    #     expect(json_response['data'].length).to eq expected_count
    #   end
    # elsif expected_count == 0 then
    #   it 'returns no results' do
    #     expect(json_response['data'].length).to eq expected_count
    #   end
    # else
    #   it 'returns list of results' do
    #     expect(json_response['data'].length).to eq expected_count
    #   end
    # end
  end
end


shared_examples 'creatable resource' do |opts = {}|
  require_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :created } 

  it 'creates resource' do
    expect(json_response.dig('data', 'attributes', opts[:fields][:name])).to eq(opts[:fields][:value])
  end
end


shared_examples 'updatable resource' do |opts = {}|
  require_let_definitions :id, :action

  before { action }
  
  it 'returns updated resource' do
    expect(json_response.dig('data', 'id')).to eq(id)
  end

  it 'updates resource'

  specify { expect(response).to have_http_status :ok }
end


shared_examples 'missing resource' do |opts = {}|
  before { example_request }
  it('returns an empty hash') { expect(json_response['data']).to eq nil }
  specify { expect(response).to have_http_status :not_found }
end


shared_examples 'bad request' do
  before { example_request }
  specify { expect(response).to have_http_status :bad_request }
end


shared_examples 'unauthorized request' do |opts = {}|
  before { example_request }
  specify { expect(response).to have_http_status :unauthorized }
  pending 'returns error message'
end


shared_examples 'forbidden request' do |opts = {}|
  before { example_request }
  specify { expect(response).to have_http_status :forbidden }
  pending 'returns error message'
end


shared_examples 'unprocessable entity request' do |opts = {}|
  before { example_request }
  specify { expect(response).to have_http_status :unprocessable_entity }
  pending 'returns error message'
end


shared_examples 'bad content type' do |opts = {}|
  before { example_request }
  specify { expect(response).to have_http_status :unsupported_media_type }
  pending 'returns error message'
end



# Helpers
def require_let_definitions(*keys)
  keys.each do |key|
    it "(example requires let block for #{key})" do
      ## https://stackoverflow.com/questions/48588739/rspec-how-to-pass-a-let-variable-as-a-parameter-to-shared-examples
      temp_config = RSpec::Expectations.configuration.on_potential_false_positives
      RSpec::Expectations.configuration.on_potential_false_positives = :nothing

      expect { send(key) }.to_not raise_error NameError

      RSpec::Expectations.configuration.on_potential_false_positives = temp_config
    end
  end
end
