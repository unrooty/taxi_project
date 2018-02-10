Sequel.migration do
  up do
    alter_table :orders do
      set_column_type :order_status, String
      set_column_default :order_status, 'New'
    end
  end

  down do
    alter_table :orders do
      set_column_type :order_status, Integer
      set_column_default :order_status, 0
    end
  end
end
