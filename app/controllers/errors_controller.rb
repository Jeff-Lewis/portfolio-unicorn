class ErrorsController < ActionController::Base

  def show
    @exception = env["action_dispatch.exception"]
    @status_code = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    respond_to do |format|
      format.html { render action: request.path[1..-1] }
      format.json { render json: error_json, status: @status_code }
    end
  end

  private
    def error_json
      json = {status: @status_code, error: @exception.message}
      if Rails.env.development?
        json[:exception] = { name: @exception.class.name, trace: @exception.backtrace }
      end
      json
    end
end