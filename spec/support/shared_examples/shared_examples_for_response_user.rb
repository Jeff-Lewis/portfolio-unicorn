shared_examples "a json serialized user response" do
  it "renders id" do
    expect(response).to have_json_key(:id)
  end

  it "renders email" do
    expect(response).to have_json_key(:email)
  end

  it "renders username" do
    expect(response).to have_json_key(:username)
  end

  it "renders authentication_token" do
    expect(response).to have_json_key(:authentication_token)
  end
  it "renders created_at" do
    expect(response).to have_json_key(:created_at)
  end

  it "does not render password" do
    expect(response).not_to have_json_key(:password)
    expect(response).not_to have_json_key(:password_confirmation)
  end
end