require 'spec_helper'

describe Yahoo::Client, type: :job do
  let(:nasdaq) {FactoryGirl.create(:nasdaq)}
  let(:securities) { (0..10).to_a.map {|i| FactoryGirl.create(:security, exchange: nasdaq)} }
  subject { Yahoo::Client.new(securities)}

  context "Fundamentals" do
    let(:url) { "d/quotes.csv?s=#{securities.map{|s| s.symbol}.join('+')}&f=#{Yahoo::FUNDAMENTALS_KEYS.join('')}" }

    it "gets the correct url" do
      mock_client = double('client') 
      subject.stub(:client).and_return(mock_client)
      expect(mock_client).to receive(:get).with(url)

      subject.fundamentals
    end
  end
end