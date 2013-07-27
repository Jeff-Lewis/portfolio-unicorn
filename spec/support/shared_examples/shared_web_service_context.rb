shared_context "Mock WebServiceClient" do
  def build_mock_client(path, response)
    ws = WebServiceClient.new("http://www.test.com/")
    ws.stub(:connection).and_return(stub_connection(path, response))
    ws
  end

  def stub_connection(path, response)
    Faraday.new do |builder|
      builder.request :url_encoded
      builder.response :raise_error
      builder.adapter :test do |stubs|
        stubs.get(path) { response }
      end
    end
  end
end