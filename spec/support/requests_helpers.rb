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

    def authenticated_header(user)
      {'Authorization': "Bearer #{generate_token(user)}"}
    end

    def api_header_for_version(version)
      {'Accept': "#{Mime[:api_json].to_s}, #{Mime[:api_json].to_s}; version=#{version}"}
    end

    def generate_http_header(opts = {})
      header = {}
      header.merge!(authenticated_header(opts[:authenticate])) if opts[:authenticate]
      header.merge!(api_header_for_version(opts[:version])) if opts[:version]
    end
    
  end


end
