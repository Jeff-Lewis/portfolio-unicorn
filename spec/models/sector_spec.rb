# == Schema Information
#
# Table name: sectors
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  industry_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Sector do
  it "has a valid factory" do
    expect(FactoryGirl.create(:sector)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:sector, name: nil)).not_to be_valid
  end

  context "Unique name scoped to industry" do
    before(:each) do
      @sector = FactoryGirl.create(:sector, name: 'SecTOr')
    end

    it "is valid with a identifical name across different industries" do
      expect(FactoryGirl.build(:sector, name: 'sector')).to be_valid
    end

    it "is invalid with a non unique name (case insensitive)" do
      expect(FactoryGirl.build(:sector, industry_id: @sector.industry_id, name: 'sector')).not_to be_valid
    end
  end

  it "has a lowercase name" do
    nasdaq = FactoryGirl.create(:sector, name: 'SECTOR')
    expect(nasdaq.name).to eq('sector')
  end

  it "is not valid without an industry" do
    expect(FactoryGirl.build(:sector, industry: nil)).not_to be_valid
  end
end
