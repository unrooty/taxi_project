Sequel.migration do
  up do
    alter_table :cars do
      set_column_not_null :brand
      set_column_not_null :car_model
      set_column_not_null :reg_number
      set_column_not_null :color
      set_column_not_null :style
      set_column_not_null :user_id
      set_column_not_null :affiliate_id
      add_constraint(:check_brand_length) { char_length(:brand) <= 25 }
      add_constraint(:check_car_model_length) { char_length(:car_model) <= 25 }
      add_constraint(:check_color_length) { char_length(:color) <= 25 }
      add_constraint(:check_style_length) { char_length(:style) <= 25 }
      add_index :reg_number, unique: true
    end
    run "ALTER TABLE cars
      ADD CONSTRAINT reg_number_regex
      CHECK ( reg_number ~ '[A-Z]{2}-[0-9]{4}-[1-7]' )"
  end

  down do
    alter_table :cars do
      set_column_allow_null :brand
      set_column_allow_null :car_model
      set_column_allow_null :reg_number
      set_column_allow_null :color
      set_column_allow_null :style
      set_column_allow_null :user_id
      set_column_allow_null :affiliate_id
      drop_constraint(:reg_number_regex)
      drop_constraint(:check_style_length)
      drop_constraint(:check_color_length)
      drop_constraint(:check_car_model_length)
      drop_constraint(:check_brand_length)
      drop_index :reg_number
    end
  end
end
