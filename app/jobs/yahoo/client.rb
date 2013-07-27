class Yahoo::Client
  attr_reader :quotes

  def initialize(securities)
    @securities = securities
  end

  def quotes
    @quotes ||= client.get api_path(quote_fields)
  end

  def fundamentals
    @fundamentals ||= client.get api_path(fundamental_fields)
  end

  private
    def api_path(options)
      "d/quotes.csv?s=#{symbols_url_encoded}&f=#{options}"
    end

    def symbols_url_encoded
      @securities.map{|s| s.symbol}.join('+')
    end

    def quote_fields
      Yahoo::QUOTE_KEYS.join('')
    end

    def fundamental_fields
      Yahoo::FUNDAMENTALS_KEYS.join('')
    end

    def client
      @client ||= WebServiceClient.new("http://download.finance.yahoo.com")
    end
end