class Api::PortfoliosController < Api::AuthenticatedController

  def index
    user = User.find(params[:user_id]) if params[:user_id]
    @portfolios = user.portfolios
  end

  def show
    @portfolio = Portfolio.find(params[:id]) if params[:id]
  end
end
