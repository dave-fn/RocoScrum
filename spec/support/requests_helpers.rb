module Requests

  module JsonHelpers

    def json_response
      JSON.parse(response.body)
    end

  end


  module AuthenticationHelpers

    def generate_token(user)
      Knock::AuthToken.new(payload: user.to_token_payload).token
    end

    def api_header(authenticate_as: nil, for_version: nil, content_type: nil)
      header = {}
      header.merge!(authenticated_header(authenticate_as)) if authenticate_as
      header.merge!(api_header_for_version(for_version)) if for_version
      header.merge!(content_type_header(content_type)) if content_type
      header
    end 

    def authenticated_header(user)
      {'Authorization' => "Bearer #{generate_token(user)}"}
    end

    def api_header_for_version(version)
      {'Accept' => "#{Mime[:api_json].to_s}, #{Mime[:api_json].to_s}; version=#{version}"}
    end

    def content_type_header(content_type)
      {'Content-Type' => content_type}
    end
    
  end


end
