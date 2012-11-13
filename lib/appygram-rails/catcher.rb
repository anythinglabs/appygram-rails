require 'appygram'
require 'json'

module AppygramRails
  class Catcher
    class << self

      def extract_http_headers(env)
        headers = {}
        env.select{|k, v| k =~ /^HTTP_/}.each do |name, value|
          proper_name = name.sub(/^HTTP_/, '').split('_').map{|upper_case| upper_case.capitalize}.join('-')
          headers[proper_name] = value
        end
        unless headers['Cookie'].nil?
          headers['Cookie'] = headers['Cookie'].sub(/_session=\S+/, '_session=[FILTERED]')
        end
        headers
      end

      def handle_with_controller(exception, controller=nil, request=nil)
        params = {}
        if controller and controller.respond_to?(:current_user)
          cu = controller.current_user
          if cu
            if cu.respond_to?(:email) and cu.email
              params['email'] = cu.email
            end
            if cu.respond_to?(:name) and cu.name
              params['name'] = cu.name
            end
          end
        end
        if request
          o = {
            'url' => (request.respond_to?(:url) ? request.url : "#{request.protocol}#{request.host}#{request.request_uri}"),
            'controller' => controller.class.to_s,
            'action' => (request.respond_to?(:parameters) ? request.parameters['action'] : request.params['action']),
            'parameters' => (request.respond_to?(:parameters) ? request.parameters : request.params),
            'request_method' => request.request_method.to_s,
            'remote_ip' => (request.respond_to?(:remote_ip) ? request.remote_ip : request.ip),
            'headers' => extract_http_headers(request.env)
          }
          params['app_json'] = JSON o
        end
        Appygram.trace(exception, params)
      end
    end
  end
end
