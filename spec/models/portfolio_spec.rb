require 'spec_helper'

describe Portfolio do

  it "is not valid without a user" do
    expect(FactoryGirl.build(:portfolio, user: nil)).not_to be_valid
  end

end
