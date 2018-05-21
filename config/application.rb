require_relative 'boot'

# require 'rails/all'

# Instead of 'rails/all', require these:
require 'active_model/railtie'
require 'active_job/railtie'
# require "active_record/railtie"
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require 'devise'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module TaxiStation
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ru
    config.i18n.available_locales = %i[en ru]
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }
    config.sequel.schema_format = :sql
    # config.active_job.queue_adapter = :delayed_job
    # config.active_record.schema_format = :sql
    config.eager_load_paths += %W[#{config.root}/lib]
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.eager_load_paths += Dir[Rails.root.join('app', 'api', '*')]
  end
end
