Sequel.migration do
  up do
    alter_table :users do
      set_column_not_null :last_name
      set_column_not_null :first_name
      set_column_not_null :phone
      add_column :unconfirmed_email, String
    end
    run "ALTER TABLE users
      ADD CONSTRAINT check_phone_length
      CHECK ( char_length(phone) = 9 )"
  end

  down do
    alter_table :users do
      set_column_allow_null :last_name
      set_column_allow_null :first_name
      set_column_allow_null :phone
      drop_constraint(:check_phone_length)
      drop_column :unconfirmed_email
    end
  end
end
