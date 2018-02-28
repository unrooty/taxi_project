Sequel.migration do
  up do
    alter_table :users do
      set_column_type :role, String
      set_column_default :role, 'Client'
      set_column_type :language, String
      set_column_default :language, 'Russian'
    end
  end

  down do
    alter_table :users do
      set_column_type :role, Integer
      set_column_default :role, 0
      set_column_type :language, Integer
      set_column_default :language, 0
    end
  end
end
