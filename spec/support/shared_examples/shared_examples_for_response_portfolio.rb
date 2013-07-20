shared_examples "a json serialized portfolio response" do
  it "renders id" do
    expect(response).to have_json_key(:id)
  end

  it "renders name" do
    expect(response).to have_json_key(:name)
  end
end

shared_examples "an array of json serialized portfolios response" do
  it "has correct number of portfolios"
  it "each portfolio is a correct serialized json - Need to think about that..."
end