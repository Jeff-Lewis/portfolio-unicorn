require 'spec_helper'

describe Api::SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:api_user]
    @user = FactoryGirl.create(:user)
  end

  context "POST #create" do
    context "valid credentials" do
      it "returns 201 created" do
        post :create, api_user: {email: @user.email, password: @user.password}, format: :json
        expect(response).to be_created
      end

      it "creates a authentication token" do
        post :create, api_user: {email: @user.email, password: @user.password}, format: :json
        expect(@user.authentication_token).not_to be_nil
      end
    end

    context "invalid credentials" do
      it "returns 401 unauthorized" do
        post :create, api_user: {email: @user.email, password: 'incorrect'}, format: :json
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
  end
end