worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout 60
preload_app true

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
