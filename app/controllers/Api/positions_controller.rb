class Api::PositionsController < Api::AuthenticatedController
  load_and_authorize_resource :portfolio
  load_and_authorize_resource :position, through: :portfolio, shallow: true

  def index
    @positions = @portfolio.positions
  end

  def show
  end
end