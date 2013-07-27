module Loggable
  extend ActiveSupport::Concern

  def logger
    Delayed::Worker.logger
  end
end