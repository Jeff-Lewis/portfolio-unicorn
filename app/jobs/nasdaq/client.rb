
class Nasdaq::Client
  def initialize(exchange_name)
    @exchange_name = exchange_name
  end

  def companies
    @companies ||= client.get(exchange_path) do |response|
      validate_response_header(response)
      response.body
    end
  end

  def exchange_path
    "screening/companies-by-industry.aspx?exchange=#{@exchange_name}&render=download"
  end

  private
    def client
      @client ||= WebServiceClient.new("http://www.nasdaq.com/")
    end

    def validate_response_header(response)
      content_disposition = response.headers["content-disposition"];
      raise Exceptions::ResourceTypeError unless content_disposition =~ /^attachment; (.+).csv$/
    end
end