Sequel.migration do
  up do
    alter_table :feedbacks do
      set_column_not_null :name
      set_column_not_null :email
      set_column_not_null :message
      add_constraint(:check_message_length) { char_length(:message) >= 10 }
    end
    run "ALTER TABLE feedbacks
      ADD CONSTRAINT email_regex
      CHECK ( email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' )"
  end

  down do
    alter_table :feedbacks do
      set_column_allow_null :name
      set_column_allow_null :email
      set_column_allow_null :message
      drop_constraint(:check_message_length)
      drop_constraint(:email_regex)
    end
  end
end
