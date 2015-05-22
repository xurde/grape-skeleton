# External dependencies
require 'json'
require 'active_record'
require 'grape'
require 'grape-swagger'

require 'api/users_endpoint'

module API

  class App < Grape::API

    CONTENT_TYPE = "application/hal+json"
    RACK_CONTENT_TYPE_HEADER = {"content-type" => CONTENT_TYPE}
    HTTP_STATUS_CODES = Rack::Utils::HTTP_STATUS_CODES.invert

    format :json
    prefix 'api'
    version 'v0', :using => :path
    content_type :json, CONTENT_TYPE


    rescue_from Grape::Exceptions::Validation do |e|
      Rack::Response.new({ message: e.message }.to_json, 412, RACK_CONTENT_TYPE_HEADER).finish
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      Rack::Response.new({ message: "The item you are looking for does not exist."}.to_json, 404, RACK_CONTENT_TYPE_HEADER).finish
    end


    helpers do

      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end

      def authenticated
        current_user
      end

    end

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
      header['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, PATCH, DELETE'
      header['Access-Control-Allow-Headers'] = 'true'
    end

    desc "Lists API routes in json"
    get '/' do
      {routes: API::App.routes.map}
    end

    desc "Returns ok status if reached"
    get 'status' do
      {status: 'ok'}
    end

    desc "Just ping"
    resource :ping do
      desc "Returns Pong"
      get '/' do
        {pong: true}
      end
    end

    params do
      optional :foo, type: String
    end
    get 'foo' do
      {foo: params[:foo]}
    end


    # Mount other api modules here

    mount API::UsersEndpoint

    add_swagger_documentation format: :json,
                              api_version: 'v0',
                              mount_path: 'swagger',
                              # base_path: "http://#{Rack::Request.host_with_port}/api/v0/",
                              info: {
                                title: 'Skeleton Grape API + Swagger'
                              }


  end

end
