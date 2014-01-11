require 'spec_helper'

describe Yahoo::Price::Job, type: :job do

  describe "initialization" do
    it "raises an error when no security_ids or exchange_name is provided"
    it "accepts a batch size option"
    it "accepts an exchange_name option"
    it "accepts a security_ids option"
    it "uses security_ids if both exchange_name and security_ids are given"
  end
end