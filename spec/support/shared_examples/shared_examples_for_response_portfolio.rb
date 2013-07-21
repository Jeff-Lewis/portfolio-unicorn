shared_examples "a json serialized portfolio response" do |prefix_path|
  it "renders id" do
    expect(json).to have_json_path("#{prefix_path}id")
  end

  it "renders name" do
    expect(json).to have_json_path("#{prefix_path}name")
  end
end

shared_examples "an array of json serialized portfolios response" do |portfolio_count|
  it "has correct number of portfolios" do
    expect(json).to have_json_size(portfolio_count)
  end

  (0..portfolio_count - 1).each do |i|
    it_behaves_like "a json serialized portfolio response", "#{i}/"
  end
end