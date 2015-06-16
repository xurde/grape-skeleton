$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))

puts "Starting RackApp with environment (#{$RACK_ENV}) in path (#{$APP_ROOT})"

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

map "/assets" do
  run assets
end

map "/docs" do
  use Rack::Static,
  :root => "./public/docs/",
  :index => 'index.html',
  :header_rules => [[:all, {'Cache-Control' => 'public, max-age=3600'}]]

  run Rack::Static
  run Rack::Directory.new("./public/docs/")
end

map "/" do
  run API::App
end
