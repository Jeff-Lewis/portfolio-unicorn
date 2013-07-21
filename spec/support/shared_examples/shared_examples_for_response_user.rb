shared_examples "a json serialized user response" do
  it "renders id" do
    expect(json).to have_json_path('id')
  end

  it "renders email" do
    expect(json).to have_json_path('email')
  end

  it "renders username" do
    expect(json).to have_json_path('username')
  end

  it "renders authentication_token" do
    expect(json).to have_json_path('authentication_token')
  end
  it "renders created_at" do
    expect(json).to have_json_path('created_at')
  end

  it "does not render password" do
    expect(json).not_to have_json_path('password')
    expect(json).not_to have_json_path('password_confirmation')
  end
end