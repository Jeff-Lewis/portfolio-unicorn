require 'spec_helper'

describe Nasdaq::Job, type: :job do
  let(:exchange) {FactoryGirl.create(:nasdaq)}
  let(:job) {Nasdaq::Job.new(exchange.name)}

  it "does not throw" do
  end
end