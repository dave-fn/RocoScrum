require 'rails_helper'
require_relative 'shared_examples/resource_access.rb'

RSpec.describe 'API - User Tokens', type: :request do

  describe 'POST /api/user_token' do
    let(:base_url)  { '/api/user_token' }
    let(:action)  { post base_url, params: user_cred, headers: http_header }
    let(:http_header)  { {'Content-Type' => 'application/json'} }

    let(:user)  { create :dummy_user }

    context 'as authenticated user' do
      let(:user_cred)  { {'auth' => {'email' => user.email, 'password' => user.password }}.to_json }

      before(:each)  { action }

      it 'returns a JWT' do
        expect(json).to have_key 'jwt'
      end

      it 'returns a JWT with hashid identifier' do
        jwt_payload = JWT.decode(json.dig('jwt'),
          Knock.token_secret_signature_key.call, Knock.token_signature_algorithm).first
        
        expect(jwt_payload.dig('sub')).to eq user.hashid
      end

      specify { expect(response).to have_http_status :created }
    end

    context 'as unauthenticated user' do
      let(:user_cred)  { {'auth' => {'email' => user.email, 'password' => '' }}.to_json }

      it_behaves_like 'missing resource'
    end
  end

end
