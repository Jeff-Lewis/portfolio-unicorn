shared_examples "a json position" do |prefix|
  it "renders id" do
    expect(json).to have_json_type(Integer).at_path("#{prefix}id")
  end

  it "renders quantity" do
    expect(json).to have_json_type(Integer).at_path("#{prefix}quantity")
  end

  it "renders average price" do
    expect(json).to have_json_type(Float).at_path("#{prefix}avg_price")
  end

  it_behaves_like "a json serialized security", "#{prefix}security/"
end

shared_examples "a json Positions array with count=" do |portfolio_count|
  it "has contains #{portfolio_count} positions" do
    expect(json).to have_json_size(portfolio_count)
  end

  (0..portfolio_count - 1).each do |i|
    it_behaves_like "a json position", "#{i}/"
  end
end