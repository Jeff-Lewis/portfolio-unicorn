require 'spec_helper'

describe Sector do
  it "has a valid factory" do
    expect(FactoryGirl.create(:sector)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:sector, name: nil)).not_to be_valid
  end

  it "is invalid with a non unique name (case insensitive)" do
    FactoryGirl.create(:sector, name: 'SecTOr')
    expect(FactoryGirl.build(:sector, name: 'sector')).not_to be_valid
  end

  it "has a lowercase name" do
    nasdaq = FactoryGirl.create(:sector, name: 'SECTOR')
    expect(nasdaq.name).to eq('sector')
  end

  it "is not valid without an industry" do
    expect(FactoryGirl.build(:sector, industry: nil)).not_to be_valid
  end
end
