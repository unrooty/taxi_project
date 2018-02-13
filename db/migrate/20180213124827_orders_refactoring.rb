Sequel.migration do
  up do
    alter_table :orders do
      set_column_not_null :end_point
      set_column_not_null :start_point
      set_column_not_null :client_name
      set_column_not_null :client_phone
      set_column_not_null :tax_id
    end
    run "ALTER TABLE orders
      ADD CONSTRAINT check_client_phone_length
      CHECK ( char_length(client_phone) = 9 )"
  end

  down do
    alter_table :orders do
      set_column_allow_null :end_point
      set_column_allow_null :start_point
      set_column_allow_null :client_name
      set_column_allow_null :client_phone
      drop_constraint(:check_client_phone_length)
      set_column_allow_null :tax_id
    end
  end
end
