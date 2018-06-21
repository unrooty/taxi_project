# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
# Fix Sequel loading issues
Rake::Task['db:create'].clear

namespace :db do
  desc 'Create the database defined in config/database.yml for the current Rails.env'
  task :create do
    database_config = {
      Rails.env => Rails.application.config_for('database')
    }

    ::SequelRails::Configuration.for(Rails.root, database_config)

    unless SequelRails::Storage.create_environment(Rails.env)
      abort "Could not create database for #{Rails.env}."
    end
  end
end
