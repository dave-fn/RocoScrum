module Requests

  module JsonHelpers

    def json
      JSON.parse(response.body)
    end
    
  end


  module HeaderHelpers

    # def generate_token(user_id)
    #   Knock::AuthToken.new(payload: {sub: user_id}).token
    # end
    def generate_token(user)
      Knock::AuthToken.new(payload: user.to_token_payload).token
    end

    # def authenticated_header(user_id)
    #   {'Authorization': "Bearer #{generate_token(user_id)}"}
    # end
    def authenticated_header(user)
      {'Authorization': "Bearer #{generate_token(user)}"}
    end

    def api_header_for_version(version)
      {'Accept': "#{Mime[:api_json].to_s}, #{Mime[:api_json].to_s}; version=#{version}"}
    end
    
  end


end
