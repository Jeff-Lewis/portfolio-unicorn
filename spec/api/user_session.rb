require 'spec_helper'

describe "API Session" do
  include_context 'API'
  
  let(:user) { FactoryGirl.create(:user) }

  context "with invalid token" do
    before(:each) do  
      post '/api/users/sign_in', token: "not-valid"
    end

    it "returns 401 Forbidden" do
      expect(last_response).to be_http_forbidden
    end
  end

  context "with valid json" do
    let(:json) { last_response.body }
    before(:each) do  
      post '/api/users/sign_in', token: user.authentication_token
    end

    it "returns 200 ok" do
      expect(last_response).to be_http_ok
    end

    it_behaves_like "a json serialized user response"
  end
end