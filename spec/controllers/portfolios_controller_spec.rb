require 'spec_helper'

describe Api::PortfoliosController do

  let(:user) { FactoryGirl.create(:user) }
  let(:json) { response.body }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end


  describe "GET #index" do
    context "Accessing own portfolios" do
      before(:each) do
        get :index, user_id: user
      end

      it "assigns the requested portfolios to @portfolios" do
        expect(assigns(:portfolios)).to eq(user.portfolios)
      end

      it "renders the :index template" do
        expect(response).to render_template('index')
      end

    end
  end

  describe "GET #show" do
    context "Acessing own portfolio" do
      before(:each) do
        @selected_portfolio = user.portfolios.sample
        get :show, id: @selected_portfolio.id
      end

      it "assigns the requested portfolio to @portfolio" do
        expect(assigns(:portfolio)).to eq(@selected_portfolio)
      end

      it "renders the :show template" do
        expect(response).to render_template('show')
      end
    end

    it "prevents access to another user's portfolio" do
      portfolio2 = FactoryGirl.create(:user).portfolios.sample
      expect {
        get :show, id: portfolio2
        }.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_attributes) { { name: "Test Portfolio"} }

      it "saves the new portfolio in the database" do
        expect{ 
          post :create, user_id: user, portfolio: valid_attributes, format: :json
        }.to change(Portfolio, :count).by(1)
      end

      it "returns 201 created" do
        post :create, user_id: user, portfolio: valid_attributes, format: :json
        expect(response).to be_created
      end
    end

    context "invalid user_id assignement" do
      let(:other_user) { FactoryGirl.create(:user) }
      let(:invalid_attributes) { {name: "Invalid Portfolio", user_id: other_user.id} }

      context "ignores the user_id passed in" do
        it "creates the the portfolio for the user specific in the url" do
          expect {
            post :create, user_id: user, portfolio: invalid_attributes, format: :json  
          }.to change(user.portfolios, :size).by(1)
        end


        it "does not create a portfolio for the user_id passed in" do
          expect {
            post :create, user_id: user, portfolio: invalid_attributes, format: :json  
          }.to change(other_user.portfolios, :size).by(0)
        end
      end

      it "return 201 created" do
        post :create, user_id: user, portfolio: invalid_attributes, format: :json  
        expect(response).to be_created
      end
    end
  end

  describe "PATCH #update" do
    it "can update the name"
    it "cannot update the user"
    it "cannot update the postions"
    it "cannot update someone else's portfolio"
  end
end
