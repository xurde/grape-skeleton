# Provide access to the Warden::Proxy in the Rack env by including this module in your Grape::API:
#
#   helpers Api::Helpers::Warden
#
# These methods require that something has configured the Warden::Manager, and
# the upstream middleware is in place to make the Warden::Proxy exist in the
# env! In a Rails app, this is typically done by Devise or rails_warden.
#
module Api::Helpers::Warden

  # Answers the Warden::Proxy from the Rack env, installing the params from the
  # Grape route into the Warden request params when we request the
  # Warden::Proxy.
  #
  #   routes.rb
  #     mount Twitter::API => '/'
  #
  #   twitter/api.rb
  #     class Twitter::API < Grape::API
  #       resource 'cars/:car_id/parts' do
  #       end
  #     end
  #
  # When Grape is used in Rails, the
  # env['action_dispatch.request.path_parameters'] does not include the
  # :car_id, nor does the env['warden'].request.params. Grape::Endpoint will
  # end up with it's own params hash, having the :app_id in it. This isn't a
  # problem unless your Warden::Strategies use the route segment :car_id.
  #
  def warden
    unless @warden
      @warden = env['warden']
      @warden.request.params.merge! params
    end
    @warden
  end

  def authenticate!
    warden.authenticate! scope: :api
  end

  def authenticate
    warden.authenticate scope: :api
  end

  def current_user
    @current_user ||= authenticate
  end

end
