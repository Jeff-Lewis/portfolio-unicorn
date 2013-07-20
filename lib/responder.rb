class Responder < ActionController::Responder
  def to_format
    controller.response.status = :created if post?
    super
  end
end