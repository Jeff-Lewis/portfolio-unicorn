class Api::PortfoliosController < Api::AuthenticatedController
  load_and_authorize_resource :user
  load_and_authorize_resource :portfolio, through: :user, shallow: true

  def index
    @portfolios = @user.portfolios
  end

  def show
  end
end
