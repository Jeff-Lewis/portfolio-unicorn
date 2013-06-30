require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.day, 'Queueing Security Symbol import job', :at => '9:30', :tz => 'UTC') {
  Exchange.all.each do |exchange|
    Delayed::Worker.logger.info "Enqueuing Import Securities job for #{exchange.name}"
    Delayed::Job.enqueue ImportSecuritiesJob.new(exchange.name)
  end
}
