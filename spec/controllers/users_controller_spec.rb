require 'spec_helper'

describe Api::UsersController do
  render_views
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:api_user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #show" do
    context "Accessing own profile" do
      before(:each) do
        get :show, id: @user
      end

      it "assigns the requested contact to @user" do
        expect(assigns(:user)).to eq(@user)
      end

      it "renders the :show template" do
        expect(response).to render_template('show')
      end

      it_behaves_like "a json serialized user response"
    end
  end

  it "prevents access to another user profile"

end