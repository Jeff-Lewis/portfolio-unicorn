require 'spec_helper'
require 'csv_helper'

RSpec.configure do |c|
  c.include Helpers
end

describe SecuritiesImporter do
  context "CSV Import New Symbol" do
    before(:each) do
      @nasdaq = FactoryGirl.create(:nasdaq)
    end

    context "Import Valid CSV" do
      before(:each) do
        @importer = SecuritiesImporter.new(@nasdaq.name, csv_apple_valid)
        @importer.import
      end

      it "creates a new security" do
        expect(Security.count).to eq(1)
      end

      it "collects the created securities" do
        expect(@importer.imported_securities.size).to eq(1)
      end

      it "has no failed import" do
        expect(@importer.failed_lines.size).to eq(0)
      end

      it "has no updated securities" do
        expect(@importer.updated_securities.size).to eq(0)
      end

      it "has no deactivated securities" do
        expect(@importer.deactivated_securities.size).to eq(0)
      end
    end

    context "Not Valid CSV" do
      before(:each) do
        @importer = SecuritiesImporter.new(@nasdaq.name, csv_apple_not_valid_empty_symbol)
        @importer.import
      end

      it "does not create a new security" do
        expect(Security.count).to eq(0)
      end

      it "collects the failed imports" do
        expect(@importer.failed_lines.length).to eq(1)
      end
    end
  end

  context "CSV Update Existing Symbol" do
    before(:each) do
      @apple = FactoryGirl.create(:aapl)
      @nasdaq = @apple.exchange
    end

    it "has a security already" do
      expect(Security.count).to eq(1)
    end

    context "Valid CSV" do
      before(:each) do
        @importer = SecuritiesImporter.new(@nasdaq.name, csv_apple_valid)
        @importer.import
      end

      it "has the same number of record" do
        expect(Security.count).to eq(1)
      end

      it "collects the updated security" do
        expect(@importer.updated_securities.length).to eq(1)
      end

      it "updates the modified field on the security" do
        updated_security = @importer.updated_securities[0]
        expect(updated_security.name).to eq("Apple Inc.")
      end
    end

    context "Previously Deactived Security" do
      before(:each) do
        @apple.update_attributes(active: false)
        @importer = SecuritiesImporter.new(@nasdaq.name, csv_apple_valid)
        @importer.import
      end
      it "reactivates the security" do
        expect(Security.find_by_symbol('aapl')).to be_active
      end

      it "collects the reactivated security" do
        expect(@importer.updated_securities.size).to eq(1)
      end
    end

    context "Not valid CSV" do
      before(:each) do
        @importer = SecuritiesImporter.new(@nasdaq.name, csv_apple_not_valid_empty_symbol)
        @importer.import
      end

      it "does not create a new security" do
        expect(Security.count).to eq(1)
      end

      it "does not update the field in the security" do
        expect(@apple.name).to eq(FactoryGirl.attributes_for(:aapl)[:name])
      end

      it "collects the failed imports" do
        expect(@importer.failed_lines.length).to eq(1)
      end
    end
  end

  context "Identical CSV" do
    it "does not save the security again" do
      apple = FactoryGirl.create(:aapl, name: "Apple Inc.")
      importer = SecuritiesImporter.new(apple.exchange.name, csv_apple_valid)
      importer.import
      expect(importer.updated_securities.size).to eq(0)
    end
  end

  context "CSV Deactivate Delisted Symbols" do
    before(:each) do
      @microsoft = FactoryGirl.create(:msft)
      @importer = SecuritiesImporter.new(@microsoft.exchange.name, csv_apple_valid)
      @importer.import
    end
    it "deactivate existing security not in the csv" do
      expect(Security.find_by_symbol('msft')).not_to be_active
    end

    it "collects the deactivated securities" do
      expect(@importer.deactivated_securities.size).to eq(1)
    end
  end
end