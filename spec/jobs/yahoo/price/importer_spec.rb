require 'spec_helper'

describe Nasdaq::Importer, type: :job do
  let(:aapl) { FactoryGirl.create(:aapl) }

  it "process csv without an error" do
    importer = Yahoo::Price::Importer.new([aapl], aapl_yahoo_quote)
    expect {
      importer.import
    }.not_to raise_error
  end
end