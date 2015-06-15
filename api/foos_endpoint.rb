module API

  class FoosEndpoint < Grape::API

    resource :foos, desc: "Just foo action with a foo required param" do

      desc "Create a foo"
      params do
        requires :foo, type: String
      end
      post '/' do
        {foo: params[:foo]}
      end

      desc "Fetch a foo"
      params do
        requires :foo_id, type: Integer
      end
      get '/:id' do
        {foo: params[:foo]}
      end

      desc "Update a foo"
      params do
        requires :foo_id, type: Integer
      end
      put '/:id' do
        {foo: params[:foo]}
      end

      desc "Destroy a foo"
      params do
        requires :foo_id, type: Integer
      end
      delete '/:id' do
        {foo: 'deleted'}
      end

    end

  end

end
