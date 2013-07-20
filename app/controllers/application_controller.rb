class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  #cancan, check authorization
  check_authorization :unless => :devise_controller?

  #this Responder make sure the http header is (201 created) when its a post method
  self.responder = Responder

  protected
  def devise_parameter_sanitizer
    if resource_class == User
      Devise::TokenParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end

end
