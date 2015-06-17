def load_path(path)
  File.join($APP_ROOT, path)
end

$LOAD_PATH << load_path(".")
$LOAD_PATH << load_path("./lib")

require 'api/app'
require 'middleware/db_connection_sweeper'
require 'middleware/logger'
require 'logger'

class ::Logger; alias_method :write, :<<; end # for Rack::CommonLogger

$LOG_FILE = "./log/#{$RACK_ENV}.log"
puts "Initializing logfile  for further loggin in: #{$LOG_FILE}"
$logger = ::Logger.new($LOG_FILE)

puts "Starting environment: #{$RACK_ENV}..."
@config = YAML.load_file('config/database.yml')[$RACK_ENV]

ActiveRecord::Base.establish_connection @config
ActiveRecord::Base.logger = $logger
