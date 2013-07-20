require 'spec_helper'

describe Api::RegistrationsController do
  render_views
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:api_user]
  end

  let(:valid_user) { {user: FactoryGirl.attributes_for(:user), format: :json} }
  let(:invalid_user) { {user: FactoryGirl.attributes_for(:invalid_user), format: :json} }

  describe "POST #create" do
   context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{ 
          post :create, valid_user
        }.to change(User, :count).by(1)
      end

      context "JSON Output" do
        before(:each) do
          post :create, valid_user
        end

        it "returns 201 created" do
          expect(response).to be_created
        end

        it_behaves_like "a json serialized user response"
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect {
          post :create, invalid_user
        }.not_to change(User, :count)
      end

      context "JSON Output" do
        before(:each) do
          post :create, invalid_user
        end
        
        it "return 422 unprocessable entity" do 
          expect(response).to be_unprocessable_entity
        end

        it "contains the errors" do
          expect(response).to have_json_key(:errors)
        end
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

    context "" do
      before(:each) do
        delete :destroy, id: @user, format: :json
      end

      it "deletes the right contact" do
        expect(User.exists?(@user.id)).to be_false
      end

      it "returns 204 No Content" do
        expect(response).to be_no_content
      end
    end
    
  end
end