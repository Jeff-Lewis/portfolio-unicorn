require 'spec_helper'

describe Nasdaq::Mapper, type: :job do

  context "Not passed in" do
    let(:security) {Nasdaq::Mapper.attributes_for(apple_row)}
    it "instantiate a new security " do
      expect(security).to be_new_record
    end

    context "Symbol" do
      it "assigns the downcased symbol from the csv" do
        expect(security.symbol).to eq('aapl')
      end
    end

    context "Name" do
      it "assigns the name from the csv" do
        expect(security.name).to eq(apple_row[Nasdaq::NAME])
      end
    end
  end

  context "Industry" do
    context "missing from CSV" do
      it "assigns nil to the industry" do
        csv = apple_row
        csv[Nasdaq::INDUSTRY] = ''
        expect(Nasdaq::Mapper.attributes_for(csv).industry).to be_nil
      end
    end

    context "not in DB" do
      it "creates a new Industry" do
        expect {
         Nasdaq::Mapper.attributes_for(apple_row) 
        }.to change(Industry,:count).by(1)
      end

      it "assigns the industry to the security" do
        security = Nasdaq::Mapper.attributes_for(apple_row) 
        expect(security.industry.name).to eq(apple_row[Nasdaq::INDUSTRY].downcase)
      end
    end

    context "already in db" do
      before(:each) do
        @industry = FactoryGirl.create(:industry, name: apple_row[Nasdaq::INDUSTRY].downcase)
      end

      it "does not create a new industry" do
        expect {
          Nasdaq::Mapper.attributes_for(apple_row)
        }.not_to change(Industry, :count)
      end

      it "assigns the retrieved industry to the security" do
        s = Nasdaq::Mapper.attributes_for(apple_row)
        expect(s.industry.id).to eq(@industry.id)
      end
    end
  end

  context "Sector" do
    context "missing from CSV" do
      it "assigns nil to the sector" do
        csv = apple_row
        csv[Nasdaq::SECTOR] = ''
        expect(Nasdaq::Mapper.attributes_for(csv).sector).to be_nil
      end
    end

    context "not in DB" do
      it "creates a new Sector" do
        expect {
         Nasdaq::Mapper.attributes_for(apple_row) 
        }.to change(Sector,:count).by(1)
      end

      it "assigns the sector to the security" do
        security = Nasdaq::Mapper.attributes_for(apple_row) 
        expect(security.sector.name).to eq(apple_row[Nasdaq::SECTOR].downcase)
      end
    end

    context "already in DB" do
      before(:each) do
        @industry = FactoryGirl.create(:industry, name: apple_row[Nasdaq::INDUSTRY].downcase)
        @sector = FactoryGirl.create(:sector, name: apple_row[Nasdaq::SECTOR].downcase, industry: @industry)
      end

      it "does not create a new sector" do
        expect {
          Nasdaq::Mapper.attributes_for(apple_row)
        }.not_to change(Sector, :count)
      end

      it "assigns the retrieved sector to the security" do
        s = Nasdaq::Mapper.attributes_for(apple_row)
        expect(s.sector.id).to eq(@sector.id)
      end
    end
  end
end