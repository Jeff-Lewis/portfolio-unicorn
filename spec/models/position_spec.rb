require 'spec_helper'

describe Position do
  it "is not valid without a position" do
    expect(FactoryGirl.build(:position, portfolio: nil)).not_to be_valid
  end

  it "is not valid without a security" do
    expect(FactoryGirl.build(:position, security: nil)).not_to be_valid
  end

  it "is not valid without a quantity" do
    expect(FactoryGirl.build(:position, quantity: nil)).not_to be_valid
  end

  it "is not valid without an avg_price" do
    expect(FactoryGirl.build(:position, avg_price: nil)).not_to be_valid
  end

  context "price validation" do
    it "is valid with a positive price" do
      expect(FactoryGirl.build(:position, avg_price: 10)).to be_valid
    end

    it "is not valid with a negative price" do
      expect(FactoryGirl.build(:position, avg_price: -10)).not_to be_valid
    end

    it "is not valid with an average price of 0" do
      expect(FactoryGirl.build(:position, avg_price: 0)).not_to be_valid
    end
  end

  it "is invalid if the portfolio already has 1 opened position on the same security" do
    p1 = FactoryGirl.create(:position)
    p2 = FactoryGirl.build(:position, portfolio: p1.portfolio, security: p1.security, quantity: p1.quantity)
    expect(p2).not_to be_valid
  end

  context "quantity validation" do
    it "is opened if the quantity is greater than 0 (long position)" do
      expect(FactoryGirl.build(:position, quantity: 10)).to be_open
    end

    it "is opened if the quantity is lower than 0 (short position)" do
      expect(FactoryGirl.build(:position, quantity: -10)).to be_open
    end

    it "is closed if the quantity is equal to 0" do
      expect(FactoryGirl.build(:position, quantity: 0)).to be_closed
    end
  end
  

end
