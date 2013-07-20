class Api::SessionsController < Devise::SessionsController
  respond_to :json

  def destroy
    current_user.reset_authentication_token!
    super
  end
end