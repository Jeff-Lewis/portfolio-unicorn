shared_examples "a case insensitive unique attribute" do |klass, attribute|
  
  it "is invalid without a #{attribute}" do
    expect(FactoryGirl.build(klass.name.underscore.to_sym, attribute => nil)).not_to be_valid
  end

  it "is invalid with a non unique #{attribute} (case insensitive)" do
    field = 'QwRtYuY'
    FactoryGirl.create(klass.name.underscore.to_sym, attribute => field)
    expect(FactoryGirl.build(klass.name.underscore.to_sym, attribute => field.downcase)).not_to be_valid
  end

  it "has a lowercase #{attribute}" do
    field = 'QWERTY'
    obj = FactoryGirl.create(klass.name.underscore.to_sym, attribute => field)
    expect(obj.send(attribute)).to eq(field.downcase)
  end
end