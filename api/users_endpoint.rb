module API

  class UsersEndpoint < Grape::API

    # helpers Api::Helpers::Warden

    namespace :users do

      get 'foo' do
        {foo: 'bar'}
      end

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
