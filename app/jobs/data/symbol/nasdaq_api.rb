module Data
  module Symbol
    class NasdaqAPI
      def initialize(exchange_name)
        @exchange_name = exchange_name
      end

      def companies
        @companies ||= client.get(exchange_url) do |response|
          validate_response_header(r)
          response.body
        end
      end

      private
        def exchange_url
          "screening/companies-by-industry.aspx?exchange=#{exchange_name}&render=download"
        end

        def client
          @client ||= Data::Symbol::Client.new("http://www.nasdaq.com/")
        end

        def validate_response_header(response)
          content_disposition = response.headers["content-disposition"];
          raise Exceptions::ResourceTypeError unless content_disposition =~ /^attachment; (.+).csv$/
        end
    end
  end
end