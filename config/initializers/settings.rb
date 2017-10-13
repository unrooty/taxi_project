SETTINGS_PATH = "#{Rails.root}/config/settings.yml".freeze
APP_SETTINGS = YAML.load_file(SETTINGS_PATH)[Rails.env]
