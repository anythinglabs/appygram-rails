# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'appygram-rails/version'

Gem::Specification.new do |gem|
  gem.name = %q{appygram-rails}
  gem.version = AppygramRails::VERSION
  gem.authors = ["rfc2616"]
  gem.summary = %q{ appygram is a hosted service for sending messages from mobile/web apps }
  gem.description = %q{appygram-rails sends uncaught Rails exceptions as traces to the hosted messaging service at http://www.appygram.com}
  gem.email = ['heittman.rob@gmail.com']
  gem.homepage = 'http://www.appygram.com/'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'appygram', '~> 1.0', '>= 1.0.3'
  gem.add_runtime_dependency 'rack'
end
