require 'rubygems'
require 'rack'

module Rack
  class RailsAppygram

    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        body = @app.call(env)
      rescue Exception => e
        unless e.is_a? ActionController::RoutingError
          ::AppygramRails::Catcher.handle_with_controller(e,env['action_controller.instance'], Rack::Request.new(env))
        end
        raise
      end

      if env['rack.exception']
        unless env['rack.exception'].is_a? ActionController::RoutingError
          ::AppygramRails::Catcher.handle_with_controller(env['rack.exception'],env['action_controller.instance'], Rack::Request.new(env))
        end
      end

      body
    end
  end
end
