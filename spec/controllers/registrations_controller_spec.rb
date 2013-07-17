require 'spec_helper'

describe Api::RegistrationsController do

  #needed by devise because we are bypassing the router and calling controller methods directly
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:api_user]
  end

  describe "POST #create" do
   def posting(hash)
     post :create, user: hash, format: :json
   end
   context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{ 
          posting FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect {
          posting FactoryGirl.attributes_for(:invalid_user)
        }.not_to change(User, :count)
      end
    end
  end
end