class User::ParameterSanitizer < Devise::ParameterSanitizer
  
  #allow assignement of username on top of what Devise normally allows
  def sign_up
    default_params.permit(*(auth_keys + [:username, :password, :password_confirmation, :username]))
    end

  def account_update
    default_params.permit(*(auth_keys + [:username, :password, :password_confirmation, :current_password]))
  end
end