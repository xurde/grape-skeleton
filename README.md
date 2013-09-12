### Service Skeleton

This is a basic skeleton for building a Ruby application/hal+json hypermedia API, which we have used with success at Reverb.com.

It is intended as a jumping off point to build services. The stack of included components:

* [Grape](https://github.com/intridea/grape) for API layer
* [Roar](https://github.com/apotonick/roar) for JSON+HAL representers
* ActiveRecord with basic rake tasks for migrations, along with middleware to manage connections within the Rack app.
* Logging middleware for Rack.
* [Mina](https://github.com/nadarei/mina) for deployment
* Thin for running the service locally
* [Foreman](https://github.com/ddollar/foreman) + Upstart for running service on Ubuntu
* Convenieces like a script/console for interacting with your code.
* Rspec for testing, Bogus for mocking and contract tests (ensure mocks are not lying to you)

See the Gemfile for more technology choices.

### How to use

* Your code goes into lib/ (organize it how you want)
* This ain't rails. `require` your classes explicitly. It's a good thing.
* A sample api endpoint has been provided inside the `api/` directory.
* We prefer to write one class per API, for example GetFoo or CreateFoo with a single endpoint.
* All API classes should be added to `api/base.rb` to get mounted into the app.
* Roar representers go into api/representers. See the [Roar](https://github.com/apotonick/roar) for more info. We prefer the decorator style pattern to the mixins.

### Caveats

* The current deployment model uses upstart to restart the service. Even though the service is quick to start, it still has downtime. We can improve this by switching to unicorn and signalling a graceful restart instead.
* This framework includes an ActiveRecord layer. It's pretty easy to swap out for other persistence.
* Logging is pretty rudimentary and can be improved in formatting.

### Migrating

Prior to launching the service, ensure you have migrated the db:

    rake db:migrate

To migrate other environments:

    rake db:migrate DATABASE_ENV=production

### Launching

Start dev env:

    script/server

Start production env:

    script/server production


### Console

For convenience, a rails-like console has been provided:

    script/console

## Deploying

First, setup the remote server with RVM:

    curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0

The first time this server has ever been deployed to, invoke this setup to create the right dirs, first checking deploy.rb for the correct ip address:

    mina setup

To deploy:

    mina deploy ENV=production
