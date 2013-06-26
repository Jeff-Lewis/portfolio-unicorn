require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.day, 'Queueing Security Symbol import job', :at => '9:00', :tz => 'UTC') {
    Delayed::Job.enqueue ScheduledJob.new 
}
