require 'spec_helper'

describe Api::PositionsController do
  render_views
  let(:position) { FactoryGirl.create(:position) }
  let(:portfolio) { position.portfolio }
  
  let(:json) { response.body }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in portfolio.user
  end


  describe "GET #index" do
    context "Accessing own positions" do
      before(:each) do
        FactoryGirl.create(:position, portfolio: portfolio)
        get :index, portfolio_id: portfolio
      end

      it "assigns the requested positions to @positions" do
        expect(assigns(:positions)).to eq(portfolio.positions)
      end

      it "renders the :index template" do
        expect(response).to render_template('index')
      end

      it_behaves_like "a json Positions array with count=", 2
    end
  end

  describe "GET #show" do
    context "Accessing own position" do
      before(:each) do
        get :show, id: position
      end

      it "assigns the requested position to @position" do
        expect(assigns(:position)).to eq(position)
      end

      it "renders the :show template" do
        expect(response).to render_template('show')
      end

      it_behaves_like "a json position"
    end
  end

  it "prevents access to another user's position" do
    someone_else_position = FactoryGirl.create(:position)
    expect {
      get :show, id: someone_else_position
      }.to raise_error(CanCan::AccessDenied)
  end
end
