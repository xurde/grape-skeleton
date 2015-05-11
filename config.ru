require File.join(File.dirname(__FILE__), 'init')

use Rack::CommonLogger, $logger
use Middleware::Logger, $logger
use Middleware::DBConnectionSweeper
use ActiveRecord::ConnectionAdapters::ConnectionManagement

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end

run API::App
