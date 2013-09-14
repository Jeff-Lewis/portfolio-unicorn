require "spec_helper"


shared_examples 'non negative prices' do |attribs|
  attribs.each do |attrib|
    it "is not valid with #{attrib} < 0" do
      expect(FactoryGirl.build(:security_price, attrib => -1)).not_to be_valid
    end
  end
end

shared_examples 'nullable prices' do |attribs|
  attribs.each do |attrib|
    it "is valid with #{attrib} = nil" do
      expect(FactoryGirl.build(:security_price, attrib => nil)).to be_valid
    end
  end
end


describe SecurityPrice do
  let(:security_price) { FactoryGirl.create(:security_price) }

  it "has a valid factory" do
    expect(FactoryGirl.build(:security_price)).to be_valid
  end

  it "is not valid without a security" do
    expect(FactoryGirl.build(:security_price, security: nil)).not_to be_valid
  end

  it "has an alias eps <-> earning_per_share" do
    expect(security_price.eps).to eq(security_price.earning_per_share)
  end

  it "has an alias pe <-> price_earning_ratio" do
    expect(security_price.pe).to eq(security_price.price_earning_ratio)
  end

  it_behaves_like "non negative prices", [
    :last_price,
    :bid,
    :ask,
    :open,
    :high,
    :low,
    :previous_close,
    :week52_low,
    :week52_high
  ]


  it_behaves_like "nullable prices", [
    :last_price,
    :bid,
    :ask,
    :open,
    :high,
    :low,
    :previous_close,
    :week52_low,
    :week52_high
  ]
end
