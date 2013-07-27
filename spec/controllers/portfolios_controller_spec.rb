require 'spec_helper'

describe Api::PortfoliosController do

  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) {user.portfolios.sample}
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
        get :show, id: portfolio
      end

      it "assigns the requested portfolio to @portfolio" do
        expect(assigns(:portfolio)).to eq(portfolio)
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
    it "can update the name" do
      patch :update, id: portfolio, portfolio: { name: "new name" }, format: :json
      expect(portfolio.reload.name).to eq("new name")
    end

    it "cannot update the user" do
      other_user = FactoryGirl.create(:user)
      patch :update, id: portfolio, portfolio: { name: 'invalid portfolio', user_id: other_user.id }, format: :json
      expect(portfolio.reload.user).to eq(user)
    end

    it "cannot update the postions" do
      FactoryGirl.create(:position, portfolio: portfolio)
      patch :update, id: portfolio, portfolio: { name: 'invalid portfolio', positions: [] }, format: :json
      expect(portfolio.reload.positions).to have(1).items
    end

    it "cannot update someone else's portfolio" do
      portfolio2 = FactoryGirl.create(:user).portfolios.sample
      expect {
        patch :update, id: portfolio2, portfolio: { name: "new name" }, format: :json
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
