namespace :db do
  desc 'Dumps the database to db/dev_APP_NAME.dump'
  task dump: :environment do
    cmd = nil
    with_config do |app, host, db, u|
      cmd = "pg_dump -Fc -v -h #{host} -U #{u} --dbname=#{db} > dev_#{app}.dump"
    end
    exec cmd
  end

  desc 'Restores the database dump at db/APP_NAME.dump.'
  task restore: :environment do
    cmd = nil
    with_config do |app, host, db, u|
      cmd = "pg_restore -v -h #{host} -U #{u} --dbname=#{db} dev_#{app}.dump"
    end
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
        ActiveRecord::Base.connection_config[:host],
        ActiveRecord::Base.connection_config[:database],
        ActiveRecord::Base.connection_config[:username]
  end
end
