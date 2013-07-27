require 'spec_helper'

describe Industry do
  it "has a valid factory" do
    expect(FactoryGirl.create(:industry)).to be_valid
  end

  it_behaves_like "a case insensitive unique attribute", Industry, :name
end
