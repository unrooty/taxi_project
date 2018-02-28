Sequel.migration do
  up do
    alter_table :cars do
      set_column_type :car_status, String
      set_column_default :car_status, 'Free'
    end
  end

  down do
    alter_table :cars do
      set_column_type :car_status, Integer
      set_column_default :car_status, 0
    end
  end
end
