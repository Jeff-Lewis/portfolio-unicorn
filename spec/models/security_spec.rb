require 'spec_helper'

describe Security do
  it "has a valid factory" do
      expect(FactoryGirl.create(:security)).to be_valid
    end

    it "is not valid without a symbol" do
      expect(FactoryGirl.build(:security, symbol: nil)).not_to be_valid
    end

    it "is not valid without a name" do
      expect(FactoryGirl.build(:security, name: nil)).not_to be_valid
    end

    it "is not valid without an exchange" do
      expect(FactoryGirl.build(:security, exchange: nil)).not_to be_valid
    end

    it "should have a lowercased symbol" do
      security = FactoryGirl.create(:security, symbol: 'AAPL');
      expect(security.symbol).to eq('aapl')
    end

    it "should be active by default" do
      security = FactoryGirl.create(:security)
      expect(security).to be_active
    end

    context "Duplicate symbol detection" do
        before(:each) do
          @lse = FactoryGirl.create(:lse)
          @apple = FactoryGirl.create(:aapl)
          @nasdaq = @apple.exchange
        end

        it "is invalid with a duplicate symbol within an exchange" do
          duplicate_symbol_security = FactoryGirl.build(:security, exchange: @nasdaq, symbol: @apple.symbol)
          expect(duplicate_symbol_security).not_to be_valid
        end

        it "is valid with a duplicate symbol from a different exchange" do
          duplicate_symbol_security = FactoryGirl.build(:security, exchange: @lse, symbol: @apple.symbol)
          expect(duplicate_symbol_security).to be_valid
        end
    end

    it "has a qualified name combining exchange name and symbol" do
      security = FactoryGirl.create(:security)
      expect(security.qualified_name).to eq("#{security.exchange.name.upcase}:#{security.symbol.upcase}")
    end
end
