require 'appygram-rails/catcher'
require 'appygram-rails/integration/rack_rails'
require 'appygram-rails/version'

module AppygramRails

  class Railtie < Rails::Railtie

    initializer "appygram.middleware" do |app|
      app.config.middleware.use "Rack::RailsAppygram"
    end

  end

  @@ignored_classes = [
    'ActiveRecord::RecordNotFound',
    'ActiveController::RoutingException'
  ]

  class << self

    def report_all_exceptions!
      @@ignored_classes = []
    end

    def ignore_exception_class_name!(k)
      @@ignored_classes << k
    end

    def ignores_exception_class?(exception)
      @@ignored_classes.each do |k|
        if exception.class.name == k
          return true
        end
      end
      false
    end

  end

end
