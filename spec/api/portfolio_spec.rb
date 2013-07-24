require 'spec_helper'

describe "API Portfolios" do
  include_context 'API'
  
  let(:user) { FactoryGirl.create(:user) }

  context "All Portfolios" do
    let(:restricted_url) { "/api/users/#{FactoryGirl.create(:user).id}/portfolios" }
    it_behaves_like "a restricted url", :get

    describe "cannot access without authenticating" do
      before(:each) do  
        get "/api/users/#{user.id}/portfolios", auth_token: "not-valid"
      end

      it "returns 401 Unauthorized" do
        expect(last_response).to be_http_unauthorized
      end
    end

    describe "accessing own profile" do
      let(:json) { last_response.body }
      before(:each) do  
        get "/api/users/#{user.id}/portfolios", auth_token: user.authentication_token
      end

      it "returns 200 ok" do
        expect(last_response).to be_http_ok
      end

      it_behaves_like "an array of json serialized portfolios response", 1
    end
  end
  
end