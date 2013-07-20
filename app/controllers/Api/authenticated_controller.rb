class Api::AuthenticatedController < Api::BaseController
  before_filter :authenticate_user!
end