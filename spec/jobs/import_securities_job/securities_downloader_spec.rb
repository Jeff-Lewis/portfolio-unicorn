require "spec_helper"
require "exceptions"

describe SecuritiesDownloader do
  def test_connection
    @test_connection ||= Faraday.new do |builder|
      builder.request :url_encoded
      builder.response :raise_error
      builder.adapter :test do |stubs|
        yield(stubs)
      end
    end
  end

  context "Retriving CSV" do
    it "fails if the url is not accessible" do
      test_connection do |stubs|
        stubs.get(SecuritiesDownloader.csv_path('nasdaq')) {[ 404, {},'']}
      end
      SecuritiesDownloader.stub(:connection).and_return(@test_connection)

      expect { SecuritiesDownloader.download('nasdaq') }.to raise_error(Faraday::Error::ClientError)
    end

    it "fails if the content-disposition header is not set properly" do
      test_connection do |stubs|
        stubs.get(SecuritiesDownloader.csv_path('nasdaq')) {[ 200, {},'something']}
      end
      SecuritiesDownloader.stub(:connection).and_return(@test_connection)

      expect{ SecuritiesDownloader.download('nasdaq') }.to raise_error(Exceptions::ResourceTypeError)
    end
  end
end