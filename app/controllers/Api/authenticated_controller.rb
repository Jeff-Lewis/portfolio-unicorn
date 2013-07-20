class Api::AuthenticatedController < Api::BaseController
  before_filter :authenticate_api_user!
end