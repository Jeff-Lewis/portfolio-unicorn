class SecuritiesDownloader

  def self.download(exchange_name)
    url = csv_path(exchange_name)
    response = connection.get url

    content_disposition = response.headers["content-disposition"];
    raise Exceptions::ResourceTypeError unless content_disposition =~ /^attachment; (.+).csv$/

    response.body
  end

  def self.csv_path(exchange_name)
    "screening/companies-by-industry.aspx?exchange=#{exchange_name}&render=download"
  end

  private
  def self.connection
    Faraday.new ("http://www.nasdaq.com/") do |faraday |
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded
      faraday.response :raise_error
    end
  end
end