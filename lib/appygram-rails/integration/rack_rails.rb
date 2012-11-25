require 'rubygems'
require 'rack'

module Rack
  class RailsAppygram

    def initialize(app)
      @app = app
    end

    def handle_with_controller(exception, controller, request)
      unless ::AppygramRails.ignores_exception_class? exception
        ::AppygramRails::Catcher.handle_with_controller(exception, controller, request)
      end
    end

    def call(env)
      begin
        body = @app.call(env)
      rescue Exception => e
        handle_with_controller(e,env['action_controller.instance'], Rack::Request.new(env))
        raise
      end

      if env['rack.exception']
        handle_with_controller(env['rack.exception'],env['action_controller.instance'], Rack::Request.new(env))
      end

      body
    end
  end
end
