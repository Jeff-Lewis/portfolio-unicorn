require 'spec_helper'

describe Api::RegistrationsController do

  #needed by devise because we are bypassing the router and calling controller methods directly
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:api_user]
    @request.accept = "application/json"
  end

  describe "POST #create" do
   context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{ 
          post :create, user: FactoryGirl.attributes_for(:user), format: :json
        }.to change(User, :count).by(1)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect {
          post :create, FactoryGirl.attributes_for(:invalid_user), format: :json
        }.not_to change(User, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "decreases the user count by 1" do
      expect {
        delete :destroy, id: @user, format: :json
      }.to change(User, :count).by(-1)
    end

    it "deletes the right contact" do
      delete :destroy, id: @user, format: :json
      expect(User.exists?(@user.id)).to be_false
    end
  end
end