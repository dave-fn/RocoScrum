shared_examples 'restricted index' do |unauthenticated: false, authenticated: false, unauthenticated_count: nil, authenticated_count: nil|
  context 'as authenticated user' do
    let(:request_headers)  { authenticated_headers }

    if authenticated
      it_behaves_like 'accessible resource', expected_count: authenticated_count
    else
      it_behaves_like 'unauthorized request'
    end
  end

  context 'as unauthenticated user' do
    let(:request_headers)  { unauthenticated_headers }

    if unauthenticated
      it_behaves_like 'accessible resource', expected_count: unauthenticated_count
    else
      it_behaves_like 'unauthorized request'
    end
  end
end


shared_examples 'restricted show' do |unauthenticated: false, authenticated: false|
  context 'as authenticated user' do
    let(:request_headers)  { authenticated_headers }

    if authenticated
      it_behaves_like 'accessible show actions'
    else
      it_behaves_like 'unauthorized request'
    end
  end

  context 'as unauthenticated user' do
    let(:request_headers)  { unauthenticated_headers }

    if unauthenticated
      it_behaves_like 'accessible show actions'
    else
      it_behaves_like 'unauthorized request'
    end
  end
end


shared_examples 'accessible show actions' do
  let(:example_request)  { get url, headers: request_headers }

  context 'when resource exists' do
    let(:url)  { available_resource_url }

    it_behaves_like 'accessible resource'
    it 'returns a single instance' do
      example_request
      expect(json_response.dig('data', 'id')).to eq(available_resource_id.to_s)
    end
  end

  context 'when resource does not exist' do
    let(:url)  { unavailable_resource_url }
    it_behaves_like 'missing resource'
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
  end
end


shared_examples 'creatable resource' do |opts = {}|
  before { example_request }
  specify { expect(response).to have_http_status :created }
  it 'creates resource' do
    expect(json_response.dig('data', 'attributes', opts[:fields][:name])).to eq(opts[:fields][:value])
  end
end


shared_examples 'updatable resource' do |opts = {}|
  before { example_request }
  it('returns updated resource') { expect(json_response.dig('data', 'id')).to eq resource_id }
  it 'updates resource' do
    expect(json_response.dig('data', 'attributes', opts[:fields][:name])).to eq(opts[:fields][:value])
  end
  specify { expect(response).to have_http_status :ok }
end


shared_examples 'deletable resource' do
  before { example_request }
  specify { expect(response).to have_http_status :no_content }
end


shared_examples 'missing resource' do
  before { example_request }
  it('returns an empty hash') { expect(json_response['data']).to eq nil }
  specify { expect(response).to have_http_status :not_found }
end


shared_examples 'bad request' do
  before { example_request }
  specify { expect(response).to have_http_status :bad_request }
end


shared_examples 'unauthorized request' do
  before { example_request }
  specify { expect(response).to have_http_status :unauthorized }
  pending 'returns error message'
end


shared_examples 'forbidden request' do
  before { example_request }
  specify { expect(response).to have_http_status :forbidden }
  pending 'returns error message'
end


shared_examples 'unprocessable entity request' do
  before { example_request }
  specify { expect(response).to have_http_status :unprocessable_entity }
  pending 'returns error message'
end


shared_examples 'bad content type' do
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
