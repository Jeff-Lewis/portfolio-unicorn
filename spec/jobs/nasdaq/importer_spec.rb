require 'spec_helper'

describe Nasdaq::Importer, type: :job do
  let(:nasdaq) { FactoryGirl.create(:nasdaq) }

  context "CSV Import New Symbol" do
    context "Import Valid CSV" do
      before(:each) do
        @importer = Nasdaq::Importer.new(nasdaq.name, csv_apple)
        @importer.import
      end

      it "creates a new security" do
        expect(Security.count).to eq(1)
      end

      it "collects the created securities" do
        expect(@importer.new_items.size).to eq(1)
      end

      it "has no failed import" do
        expect(@importer.failed_items.size).to eq(0)
      end

      it "has no updated securities" do
        expect(@importer.updated_items.size).to eq(0)
      end

      it "has no deactivated securities" do
        expect(@importer.deactivated_securities.size).to eq(0)
      end
    end

    context "Not Valid CSV" do
      before(:each) do
        @importer = Nasdaq::Importer.new(nasdaq.name, csv_apple_not_valid_empty_symbol)
        @importer.import
      end

      it "does not create a new security" do
        expect(Security.count).to eq(0)
      end

      it "collects the failed imports" do
        expect(@importer.failed_items.length).to eq(1)
      end
    end
  end

  context "CSV Update Existing Symbol" do
    before(:each) do
      @apple = FactoryGirl.create(:aapl, exchange: nasdaq)
    end

    it "has a security already" do
      expect(Security.count).to eq(1)
    end

    context "Valid CSV" do
      before(:each) do
        @importer = Nasdaq::Importer.new(nasdaq.name, csv_apple)
        @importer.import
      end

      it "has the same number of record" do
        expect(Security.count).to eq(1)
      end

      it "collects the updated security" do
        expect(@importer.updated_items.length).to eq(1)
      end

      it "updates the modified field on the security" do
        updated_security = @importer.updated_items[0]
        expect(updated_security.name).to eq("Apple Inc.")
      end
    end

    context "Previously Deactived Security" do
      before(:each) do
        @apple.update_attributes(active: false)
        @importer = Nasdaq::Importer.new(nasdaq.name, csv_apple)
        @importer.import
      end
      it "reactivates the security" do
        expect(Security.find_by_symbol('aapl')).to be_active
      end

      it "collects the reactivated security" do
        expect(@importer.updated_items.size).to eq(1)
      end
    end

    context "Not valid CSV" do
      before(:each) do
        @importer = Nasdaq::Importer.new(nasdaq.name, csv_apple_not_valid_empty_symbol)
        @importer.import
      end

      it "does not create a new security" do
        expect(Security.count).to eq(1)
      end

      it "does not update the field in the security" do
        expect(@apple.name).to eq(FactoryGirl.attributes_for(:aapl)[:name])
      end

      it "collects the failed imports" do
        expect(@importer.failed_items.length).to eq(1)
      end
    end
  end

  context "Identical CSV" do
    it "does not save the security again" do
      apple = FactoryGirl.create(:aapl, name: "Apple Inc.")
      importer = Nasdaq::Importer.new(apple.exchange.name, csv_apple)
      importer.import
      expect(importer.updated_items.size).to eq(0)
    end
  end

  context "CSV Deactivate Delisted Symbols" do
    before(:each) do
      @microsoft = FactoryGirl.create(:msft)
      @importer = Nasdaq::Importer.new(@microsoft.exchange.name, csv_apple)
      @importer.import
    end
    it "deactivate existing security not in the csv" do
      expect(Security.find_by_symbol('msft')).not_to be_active
    end

    it "collects the deactivated securities" do
      expect(@importer.deactivated_securities.size).to eq(1)
    end
  end

  context "Symbol contains a carret" do
    before(:each) do
      @importer = Nasdaq::Importer.new(nasdaq.name, csv_symbol_dash)
      @importer.import
    end
    it "converts the caret to a dash" do
      expect(@importer.new_items[0].symbol).to eq('utx-a')
    end
  end
end