class ApiConstraint

  def initialize(version:, default: false)
    @version = version
    @default = default
  end

  def matches?(request)
    (request.respond_to?('headers') && check_headers(request.headers)) || @default
  end


  private

  def check_headers(headers)
    accept_header = headers[:accept]
    return false if accept_header.nil?
    accept_header.include?(jsonapi_media_type_and_version)
  end

  def jsonapi_media_type_and_version
    "#{Mime[:api_json]}; version=#{@version}"
  end

end
