require_relative 'boot'

require 'rails'

%w(
  action_controller/railtie
  action_view/railtie
  action_mailbox/engine
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GcloudBug
  class Application < Rails::Application
    config.load_defaults 6.0
    config.hosts = nil

    config.action_dispatch.show_exceptions = false
    config.consider_all_requests_local = true
    config.action_controller.allow_forgery_protection = false

    config.session_store :cookie_store, :key => '_session'
    config.secret_token = 'a_test_token'
    config.secret_key_base = 'a_test_secret'

    config.cache_classes = false
    config.eager_load = false

    if Rails.root.join('tmp', 'caching-dev.txt').exist?
      config.action_controller.perform_caching = true
      config.action_controller.enable_fragment_cache_logging = true
      config.cache_store = :memory_store
      config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{2.days.to_i}"
      }
    else
      config.action_controller.perform_caching = false
      config.cache_store = :null_store
    end

    config.active_support.deprecation = :log

    config.assets.debug = true
    config.assets.quiet = true
    config.assets.check_precompiled_asset = false

    config.serve_static_files = true

    # config.logger = Logger.new($stdout)
    # config.log_level = :warn
  end
end
