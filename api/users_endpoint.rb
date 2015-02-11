module API

  class UsersEndpoint < Grape::API

    namespace :users do
      get 'foo' do
        {foo: 'bar'}
      end
    end

  end

end
