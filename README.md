# Appygram <http://www.appygram.com> - for Rails 3

Appygram is a messaging service for web and mobile apps.

This Gem/Plugin is for Rails applications. It will send uncaught
exception reports (server error pages / "500 errors") to the
Appygram trace service, which will count them and send notifications
as appropriate.

## Rails Installation

1.  Add the appygram-rails gem entry to your Gemfile
    
    ```ruby
    gem 'appygram-rails'
    ```
    
2.  Run <code>bundle install</code>

3.  Configure your API Key. If you will use Appygram in both development
    and production, you can put it in an initializer, e.g.
    <code>config/initializers/appygram.rb</code>. Otherwise, just put
    it in <code>config/environments/production.rb</code>:
    
    ```ruby
    Appygram.configure :api_key => 'your_api_key'
    ```
    
    Use a valid API key for your app provided by Appygram.

4.  A restart is required to pick up new gems and configuration.

## Additional configuration

To properly route messages about exception traces, you will probably
want to at least set the default topic to some topic name configured
in your Appygram dashboard:

```ruby
Appygram.configure :topic => 'Uncaught Exception'
```

For more configuration options, see the instructions for the core
Appygram gem: <https://github.com/anythinglabs/appygram.rb>

You can also read there about how to programmatically call Appygram
to send user-generated messages or rescued exceptions.

## Automatic devise (and similar) integration

If an exception occurs within any Rails controller that responds
to "current_user", this gem will auto-fill the "name" and "email"
properties of the trace with the associated properties of
current_user.

## Automatic context information

The current request context, including URI, parameters, and
headers, is serialized into the app_json field of the trace.

Copyright © 2012 Solertium.
