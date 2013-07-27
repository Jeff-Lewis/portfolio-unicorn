class Api::PositionsController < Api::AuthenticatedController
  load_and_authorize_resource :portfolio
  load_and_authorize_resource :position, through: :portfolio, shallow: true

  def index
    @positions = @portfolio.positions
  end

  def show
  end

  def create
    @position.portfolio = @portfolio
    @position.save
    respond_with @position
  end

  def update
    @position.update!(position_params)
    respond_with @position
  end

  private
    def position_params
      if request.post?
        params.require(:position).permit(:quantity, :avg_price, :security_id)
      elsif request.patch? || request.put?
        params.require(:position).permit(:quantity, :avg_price) #not allowed to update the security_id once set
      end
    end
end