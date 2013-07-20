require 'spec_helper'

describe Api::PortfoliosController do
  render_views
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    context "Accessing own portfolios" do
      before(:each) do
        get :index, user_id: @user
      end

      it "assigns the requested portfolios to @portfolios" do
        expect(assigns(:portfolios)).to eq(@user.portfolios)
      end

      it "renders the :index template" do
        expect(response).to render_template('index')
      end

      it_behaves_like "an array of json serialized portfolios response"
    end

    it "return 401 when acceessing another user's portfolios"
  end

  describe "GET #show" do
    context "Accessing own portfolio" do
      before(:each) do
        @selected_portfolio = @user.portfolios.sample
        get :show, id: @selected_portfolio.id
      end

      it "assigns the requested portfolio to @portfolio" do
        expect(assigns(:portfolio)).to eq(@selected_portfolio)
      end

      it "renders the :show template" do
        expect(response).to render_template('show')
      end

      it_behaves_like "a json serialized portfolio response"
    end
  end

  it "prevents access to another user's portfolio"
end
