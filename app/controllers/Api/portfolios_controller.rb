class Api::PortfoliosController < Api::AuthenticatedController
  before_filter :new_portfolio, :only => [:create]

  load_and_authorize_resource :user
  load_and_authorize_resource :portfolio, through: :user, shallow: true

  def index
    @portfolios = @user.portfolios
  end

  def show
  end

  def create
    @portfolio.user = current_user
  end

  private
    def new_portfolio
      @portfolio = Portfolio.new(portfolio_params)
    end

    def portfolio_params
      params.require(:portfolio).permit(:name)
    end

end
