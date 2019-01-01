require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - User Tokens', type: :request do

  let(:url_base)  { '/api/user_token' }

  describe 'POST /api/user_token' do
    let(:request)  { post url, params: credentials }
    let(:url)  { url_base }
    let(:user)  { create :dummy_user }

    context 'as authenticated user' do
      let(:credentials)  { {'auth' => {'email' => user.email, 'password' => user.password}} }

      before(:each)  { request }

      it 'returns a JWT' do
        expect(json_response).to have_key 'jwt'
      end

      it 'returns a JWT with hashid identifier' do
        jwt_payload = JWT.decode(json_response.dig('jwt'),
          Knock.token_secret_signature_key.call, Knock.token_signature_algorithm).first
        
        expect(jwt_payload.dig('sub')).to eq user.hashid
      end

      specify { expect(response).to have_http_status :created }
    end

    context 'as unauthenticated user' do
      let(:credentials)  { {'auth' => {'email' => user.email, 'password' => ''}} }

      it_behaves_like 'missing resource' do
        let(:example_request)  { request }
      end
    end
  end

end
