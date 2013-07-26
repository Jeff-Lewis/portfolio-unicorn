require 'spec_helper'

describe Api::PositionsController do

  let(:position) { FactoryGirl.create(:position) }
  let(:portfolio) { position.portfolio }
  
  let(:json) { response.body }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in portfolio.user
  end


  describe "GET #index" do
    before(:each) do
      get :index, portfolio_id: portfolio
    end

    it "assigns the requested positions to @positions" do
      expect(assigns(:positions)).to eq(portfolio.positions)
    end

    it "renders the :index template" do
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    before(:each) do
      get :show, id: position
    end

    it "assigns the requested position to @position" do
      expect(assigns(:position)).to eq(position)
    end

    it "renders the :show template" do
      expect(response).to render_template('show')
    end
  end

  it "prevents access to another user's position" do
    someone_else_position = FactoryGirl.create(:position)
    expect {
      get :show, id: someone_else_position
      }.to raise_error(CanCan::AccessDenied)
  end
end
