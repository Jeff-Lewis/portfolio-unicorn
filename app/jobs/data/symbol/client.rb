module Data
  module Symbol
    class Client
      def initialize(base_url)
        @connection = Faraday.new (base_url) do |faraday |
          faraday.adapter Faraday.default_adapter
          faraday.request :url_encoded
          faraday.response :raise_error
        end
      end

      def get(url, &validate)
        response = @connection.get(url)
        if block_given?
          validate.call(response) 
        else
          response.body
        end
      end
    end
  end
end
