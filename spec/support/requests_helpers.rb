module Requests

  module JsonHelpers

    def json
      JSON.parse(response.body)
    end
    
  end


  module HeaderHelpers

    def api_header_for_version(version)
      {'Accept': "#{Mime[:api_json].to_s}, #{Mime[:api_json].to_s}; version=#{version}"}
    end
    
  end


end
