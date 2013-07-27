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

  context "Modifying Resources" do
    let(:security) { FactoryGirl.create(:security) } 

    describe "POST #create" do
      context "with valid attributes" do
        let(:valid_attributes) { FactoryGirl.attributes_for(:position, portfolio: nil, security_id: security.id)}
        it "saves the new portfolio in the database" do
          expect{ 
            post :create, portfolio_id: portfolio, position: valid_attributes, format: :json
          }.to change(portfolio.positions, :count).by(1)
        end

        it "returns 201 created" do
          post :create, portfolio_id: portfolio, position: valid_attributes, format: :json
          expect(response).to be_created
        end
      end

      context "invalid portfolio_id assignement" do
        let(:other_portfolio) { FactoryGirl.create(:portfolio) }
        let(:invalid_attributes) { FactoryGirl.attributes_for(:position, portfolio_id: other_portfolio.id, security_id: security.id) }

        context "ignores the portfolio_id passed in" do
          it "creates the the position for the portfolio specified in the url" do
            expect {
              post :create, portfolio_id: portfolio, position: invalid_attributes, format: :json  
            }.to change(portfolio.positions, :size).by(1)
          end


          it "does not create a position for the portfolio_id passed in" do
            expect {
              post :create, portfolio_id: portfolio, position: invalid_attributes, format: :json  
            }.to change(other_portfolio.positions, :size).by(0)
          end
        end

        it "return 201 created" do
          post :create, portfolio_id: portfolio, position: invalid_attributes, format: :json  
          expect(response).to be_created
        end
      end
    end

    describe "PATCH #update" do

      context "Successfull updates" do
        before(:each) do
          patch :update, id: position, position: { quantity: 12, avg_price: 123.45 }, format: :json
        end

        it "renders the :update template" do
          expect(response).to render_template('update')
        end

        it "can update quantity" do
          expect(position.reload.quantity).to eq(12)
        end

        it "can update avg_price" do
          expect(position.reload.avg_price.amount).to eq(123.45)
        end
      end
      
      it "cannot update security" do
        patch :update, id: position, position: { quantity: 10, security_id: security.id }, format: :json
        expect(position.reload.security).not_to eq(security)
      end
      
      it "cannot update portfolio" do
        other_portfolio = FactoryGirl.create(:portfolio)
        patch :update, id: position, position: { quantity: 10, portfolio_id: other_portfolio.id }, format: :json
        expect(position.reload.portfolio).not_to eq(other_portfolio)
      end
    end
  end
end
