require "spec_helper"

describe Exchange do
    it "has a valid factory" do
        expect(FactoryGirl.create(:exchange)).to be_valid
    end

    it "is invalid without a name" do
        expect(FactoryGirl.build(:exchange, name: nil)).not_to be_valid
    end

    it "is invalid with a non unique name (case insensitive)" do
        FactoryGirl.create(:exchange, name: 'nasdaq')
        expect(FactoryGirl.build(:exchange, name: 'NASDAQ')).not_to be_valid
    end

    it "has a lowercase name" do
        nasdaq = FactoryGirl.create(:exchange, name: 'NASDAQ')
        expect(nasdaq.name).to eq('nasdaq')
    end
end
