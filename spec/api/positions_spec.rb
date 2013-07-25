require 'spec_helper'

describe "API Positions" do
  include_context 'API'
  
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { position.portfolio.user }

  context "All Positions" do
    let(:restricted_url) { "/api/portfolios/#{FactoryGirl.create(:portfolio).id}/positions" }
    it_behaves_like "a restricted url", :get

    describe "cannot access without authenticating" do
      before(:each) do  
        get "/api/portfolios/#{position.portfolio.id}/", auth_token: "not-valid"
      end

      it "returns 401 Unauthorized" do
        expect(last_response).to be_http_unauthorized
      end
    end

    describe "accessing own positions" do
      let(:json) { last_response.body }
      before(:each) do  
        get "/api/portfolios/#{position.portfolio.id}/positions", auth_token: user.authentication_token
      end

      it "returns 200 ok" do
        expect(last_response).to be_http_ok
      end

      it_behaves_like "a json Positions array with count=", 1
    end
  end

  context "Single Position" do
    describe "accessing own position" do
      let(:json) { last_response.body }
      before(:each) do  
        get "/api/positions/#{position.id}/", auth_token: user.authentication_token
      end

      it "returns 200 ok" do
        expect(last_response).to be_http_ok
      end

      it_behaves_like "a json position"
    end
  end
  
end