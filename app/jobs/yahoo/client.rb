class Yahoo::Client
  attr_reader :quotes, :securities

  def initialize(securities)
    @securities = securities
  end

  def quotes
    @quotes ||= client.get api_path(fields)
  end

  private
    def api_path(options)
      "d/quotes.csv?s=#{symbols_url_encoded}&f=#{options}"
    end

    def symbols_url_encoded
      @securities.map{|s| s.symbol}.join('+')
    end

    def fields
      Yahoo::KEYS.join('')
    end

    def client
      @client ||= WebServiceClient.new("http://download.finance.yahoo.com")
    end
end