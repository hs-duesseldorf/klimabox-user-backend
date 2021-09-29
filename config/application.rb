require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KlimaboxBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.url = config_for(:url)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoloader = :classic

    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use ActionDispatch::Cookies
    config.middleware.insert_before 0, Rack::Cors do
      allow do
         origins 'http://localhost:3001'
         resource '*', headers: :any, credentials: true, methods: [:get, :post, :patch, :delete, :options]
       end
    end
  end
end
