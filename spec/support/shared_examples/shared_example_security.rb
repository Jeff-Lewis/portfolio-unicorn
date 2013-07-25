shared_examples "a json serialized security" do |prefix|
  it "renders id" do
    expect(json).to have_json_type(Integer).at_path("#{prefix}id")
  end

  it "renders symbol" do
    expect(json).to have_json_type(String).at_path("#{prefix}symbol")
  end

  it "renders name" do
    expect(json).to have_json_type(String).at_path("#{prefix}name")
  end

  it "renders exchange" do
    expect(json).to have_json_type(String).at_path("#{prefix}exchange")
  end

end