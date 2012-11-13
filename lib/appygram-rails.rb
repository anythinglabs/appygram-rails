require 'appygram-rails/catcher'
require 'appygram-rails/integration/rack_rails'
require 'appygram-rails/version'

module AppygramRails

  class Railtie < Rails::Railtie

    initializer "appygram.middleware" do |app|
      app.config.middleware.use "Rack::RailsAppygram"
    end

  end

end
