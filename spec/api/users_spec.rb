require 'spec_helper'

describe "API Users" do
  include_context 'API'
  
  let(:user) { FactoryGirl.create(:user) }

  let(:restricted_url) { "/api/users/#{FactoryGirl.create(:user).id}" }
  it_behaves_like "a restricted url", :get

  describe "cannot access without authenticating" do
    before(:each) do  
      get "/api/users/#{user.id}", auth_token: "not-valid"
    end

    it "returns 401 Unauthorized" do
      expect(last_response).to be_http_unauthorized
    end
  end

  describe "accessing own profile" do
    let(:json) { last_response.body }
    before(:each) do  
      get "/api/users/#{user.id}", auth_token: user.authentication_token
    end

    it "returns 200 ok" do
      expect(last_response).to be_http_ok
    end

    it_behaves_like "a json serialized user response"
  end
end