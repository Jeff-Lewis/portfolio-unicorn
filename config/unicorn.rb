worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 15)
preload_app true

before_fork do |server, worker|
    Signal.trap 'TERM' do
        puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
        Process.kill 'QUIT', Process.pid
    end

    defined?(ActiverRecord::Base) and ActiverRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
     Signal.trap 'TERM' do
        puts 'Unicorn master intercepting TERM and doing nothing. Wait for master to send QUIT'
    end

    defined?(ActiverRecord::Base) and ActiverRecord::Base.establish_connection
end
