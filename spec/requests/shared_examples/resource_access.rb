shared_examples 'unrestricted index' do |url, opts = {}|
  requires_let_definitions :api_header

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:rqst_opts)               { '' }
    let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: api_header }

    it_behaves_like 'accessible resource', count: opts[:count] do
      let(:action)  { action_unauthenticated }
    end
  end

  context 'as authenticated user' do
    requires_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { api_header.merge(authenticated_header(user)) }
    let(:rqst_opts)             { '' }
    let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

    it_behaves_like 'accessible resource', count: opts[:count] do
      let(:action)  { action_authenticated }
    end
  end
end


shared_examples 'restricted index' do |url, opts = {}|
  requires_let_definitions :api_header

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:rqst_opts)               { '' }
    let(:action_unauthenticated)  { get "#{base_url}?#{rqst_opts}", headers: api_header }

    it_behaves_like 'unauthorized request', count: opts[:count] do
      let(:action)  { action_unauthenticated }
    end
  end

  context 'as authenticated user' do
    requires_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { api_header.merge(authenticated_header(user)) }
    let(:rqst_opts)             { '' }
    let(:action_authenticated)  { get "#{base_url}?#{rqst_opts}", headers: auth_header }

    it_behaves_like 'accessible resource', count: opts[:count] do
      let(:action)  { action_authenticated }
    end
  end
end


shared_examples 'unrestricted show' do |url, opts = {}|
  requires_let_definitions :resource_id, :api_header

  let(:base_url)  { url }

  let(:action_unauthenticated)  { get "#{base_url.sub(':id', resource_id.to_s)}", headers: api_header }

  context 'when resource exists' do
    it_behaves_like 'accessible resource' do
      let(:action)  { action_unauthenticated }
    end

    it 'returns a single instance' do
      action_unauthenticated
      expect(json.dig('data', 'id')).to eq(resource_id.to_s)
    end
  end

  context 'when resource does not exist' do
    let(:resource_id)  { -1 }

    it_behaves_like 'missing resource' do
      let(:action)  { action_unauthenticated }
    end
  end
end


shared_examples 'restricted create' do |url, update_params, opts = {}|
  requires_let_definitions :api_header, :resource_params, :invalid_params, :missing_params

  let(:base_url)  { url }

  context 'as unauthenticated user' do
    let(:action_unauthenticated)  { post base_url, params: resource_params.to_json, headers: api_header }

    context 'missing Content-Type' do  
      let(:api_header)  { {'Content-Type': 'application/vnd.json'} }

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
    requires_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { api_header.merge(authenticated_header(user)) }
    let(:rqst_headers)          { api_header.merge auth_header }
    let(:action_authenticated)  { post base_url, params: resource_params.to_json, headers: rqst_headers }

    context 'missing Content-Type'do  
      let(:api_header)  { {'Content-Type': 'application/vnd.json'} }

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
  requires_let_definitions :content_header, :resource_id, :resource_params, :invalid_params

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
    requires_let_definitions :user
    # let(:user)                  { create :user }
    let(:auth_header)           { api_header.merge(authenticated_header(user)) }
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


shared_examples 'accessible resource' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :ok }

  if opts[:count] then
    if opts[:count] == 1 then
      it 'returns a single object' do
        expect(json['data'].length).to eq opts[:count]
      end
    elsif opts[:count] == 0 then
      it 'returns no objects' do
        expect(json['data'].length).to eq opts[:count]
      end
    else
      it 'returns list of objects' do
        expect(json['data'].length).to eq opts[:count]
      end
    end
  end
end


shared_examples 'creatable resource' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :created } 

  it 'creates resource' do
    expect(json.dig('data', 'attributes', opts[:fields][:name])).to eq(opts[:fields][:value])
  end
end


shared_examples 'updatable resource' do |opts = {}|
  requires_let_definitions :id, :action

  before { action }
  
  it 'returns updated resource' do
    expect(json.dig('data', 'id')).to eq(id)
  end

  it 'updates resource'

  specify { expect(response).to have_http_status :ok }
end


shared_examples 'missing resource' do |opts = {}|
  requires_let_definitions :action

  before { action }

  it 'returns an empty hash' do
    expect(json['data']).to be_nil
  end
  
  specify { expect(response).to have_http_status :not_found }
end


shared_examples 'bad request' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :bad_request }
end


shared_examples 'unauthorized request' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :unauthorized }
  pending 'returns error message'
end


shared_examples 'forbidden request' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :forbidden }
  pending 'returns error message'
end


shared_examples 'unprocessable entity request' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :unprocessable_entity }
  pending 'returns error message'
end


shared_examples 'bad content type' do |opts = {}|
  requires_let_definitions :action

  before { action }

  specify { expect(response).to have_http_status :unsupported_media_type }
  pending 'returns error message'
end



# Helpers
def requires_let_definitions(*keys)
  keys.each { |key| raise "Pass #{key} as let block" unless defined? key }
end
