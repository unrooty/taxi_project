Sequel.migration do
  up do
    alter_table :affiliates do
      set_column_not_null :name
      set_column_not_null :address
      add_index Sequel.function(:lower, :name), unique: true
    end
  end

  down do
    alter_table :affiliates do
      set_column_allow_null :name
      set_column_allow_null :address
      drop_index(Sequel.function(:lower, :name))
    end
  end
end
