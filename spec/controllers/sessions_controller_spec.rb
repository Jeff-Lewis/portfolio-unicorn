require 'spec_helper'

describe Api::SessionsController do
  render_views
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
  end
  let(:json) { response.body }

  context "POST #create" do
    context "valid credentials" do
      before(:each) do
        post :create, user: {email: @user.email, password: @user.password}, format: :json
      end

      it "returns 201 created" do
        expect(response).to be_created
      end

      it "creates a authentication token" do
        @user.reload
        expect(@user.authentication_token).not_to be_nil
      end

      it_behaves_like "a json serialized user response"
    end

    context "invalid credentials" do
      it "returns 401 unauthorized" do
        post :create, user: {email: @user.email, password: 'incorrect'}, format: :json
        expect(response).to be_unauthorized
      end
    end
  end


  context "DELETE #destroy" do
    it "destroy the current authentication token" do
      sign_in @user
      old_token = @user.authentication_token
      delete :destroy, format: :json
      @user.reload
      expect(@user.authentication_token).not_to eq(old_token)
    end

    it "returns 200 no content" do
      expect(response).to be_ok
    end
  end
end