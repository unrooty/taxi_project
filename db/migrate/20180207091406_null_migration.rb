Sequel.migration do
  up do
    run File.read('db/migrate/null_schema.sql')
  end

  down do
    raise Sequel::Error, 'Irreversible Migration!'
  end
end
