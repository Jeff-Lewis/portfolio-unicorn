class Api::PortfoliosController < Api::AuthenticatedController  
  load_and_authorize_resource :user
  load_and_authorize_resource :portfolio, through: :user, shallow: true

  def index
    @portfolios = @user.portfolios
  end

  def show
  end

  def create
    @portfolio.user = @user
    @portfolio.save
    respond_with @portfolio
  end

  def update
    @portfolio.update!(portfolio_params)
    respond_with @portfolio
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:name) unless request.get?
    end

end
