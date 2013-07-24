require 'spec_helper'

describe "API Registration" do
  include_context 'API'

  context "with invalid json" do
    let(:invalid_json) { {user: FactoryGirl.attributes_for(:invalid_user)}.to_json }
    before(:each) do  
      post '/api/users', invalid_json
    end

    it "returns 422 Unprocessable entity" do
      expect(last_response).to be_http_unprocessable_entity
    end

    it "returns the validation errors" do
      expect(last_response.body).to have_json_size(1).at_path('errors')
    end
  end

  context "with valid json" do
    let(:valid_json) { {user: FactoryGirl.attributes_for(:user)}.to_json }
    let(:json) { last_response.body }
    before(:each) do  
      post '/api/users', valid_json
    end

    it "returns 201 Created" do
      expect(last_response).to be_http_created
    end

    it_behaves_like "a json serialized user response"
  end
end