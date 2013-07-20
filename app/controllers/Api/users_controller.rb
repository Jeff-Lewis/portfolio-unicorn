class Api::UsersController < Api::AuthenticatedController

  def show
    @user = User.find(params[:id])
  end

end