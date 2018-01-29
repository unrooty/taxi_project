require_relative 'boot'

require 'rails/all'

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
    config.cache_store = :redis_store, ENV['REDIS_URL'],
                         { expires_in: 90.minutes }
    config.active_job.queue_adapter = :delayed_job
    config.active_record.schema_format = :ruby
  end
end
