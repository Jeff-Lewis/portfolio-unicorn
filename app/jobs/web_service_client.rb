class WebServiceClient
  include Loggable

  def initialize(base_url)
    @base_url = base_url
  end

  def get(url, &validate)
    response = connection.get(url)
    if block_given?
      validate.call(response) 
    else
      response.body
    end
  end

  def connection
    @connection ||= Faraday.new (@base_url) do |faraday |
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded
      faraday.response :raise_error
      faraday.response :logger, logger
    end
  end
end
