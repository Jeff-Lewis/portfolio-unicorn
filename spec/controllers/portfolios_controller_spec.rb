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

    it "prevents access to another user's portfolio" do
      user2 = FactoryGirl.create(:user)
      expect {
        get :show, id: user2.portfolios.sample
        }.to raise_error(CanCan::AccessDenied)
    end
  end
end
