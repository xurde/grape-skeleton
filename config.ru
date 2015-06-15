$APP_ROOT = File.expand_path(File.dirname(__FILE__))
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

require 'sprockets'
assets = Sprockets::Environment.new($APP_ROOT) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join($APP_ROOT, 'assets'))
assets.append_path(File.join($APP_ROOT, 'assets', 'swagger-ui'))
assets.append_path(File.join($APP_ROOT, 'assets', 'javascripts'))
assets.append_path(File.join($APP_ROOT, 'assets', 'stylesheets'))

map "/assets" do
  run assets
end

run API::App
