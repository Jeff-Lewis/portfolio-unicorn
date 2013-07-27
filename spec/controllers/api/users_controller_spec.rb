require 'spec_helper'

describe Api::UsersController do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  let(:json) { response.body }

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
    end
  end

  it "prevents access to another user profile" do
    user2 = FactoryGirl.create(:user)
    expect {
      get :show, id: user2
      }.to raise_error(CanCan::AccessDenied)
  end

end