shared_context "API" do
  before(:each) do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
  end
end