require 'spec_helper'
require 'exceptions'

describe Nasdaq::Client, type: :job do
  include_context 'Mock WebServiceClient'

  let(:exchange) {FactoryGirl.create(:nasdaq)}
  subject { Nasdaq::Client.new exchange.name}

  before(:each) do
    subject.stub(:client).and_return(mock_client) 
  end

  context "Valid URL" do
    context "Valid Content type header" do
      let(:mock_client) { build_mock_client(subject.exchange_path, [ 200, {'content-disposition'=> 'attachment; test.csv'},'test']) }
      it "assigns the body to companies" do
        expect(subject.companies).to eq('test')
      end
    end

    context "invalid content type header" do
      let(:mock_client) { build_mock_client(subject.exchange_path, [ 200, {},'test']) }
      it "throws an error" do
        expect{
          subject.companies
        }.to raise_error(Exceptions::ResourceTypeError)
      end
    end
  end

  context "URL not accessible" do
    let(:mock_client) { build_mock_client(subject.exchange_path, [ 404, {},'test']) }
    it "throws an error" do
      expect{
        subject.companies
      }.to raise_error(Faraday::Error::ClientError)
    end
  end
   
end