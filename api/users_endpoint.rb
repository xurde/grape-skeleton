module API

  class UsersEndpoint < Grape::API

    # helpers Api::Helpers::Warden

    namespace :users do

      namespace :auth do

        post do
          {user_token: 'XXXXXXXXXXXXXXXXXXX'}
        end

        get do
          {user: current_user}
        end

      end
    end

  end

end
