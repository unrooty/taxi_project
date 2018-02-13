Sequel.migration do
  up do
    alter_table :taxes do
      set_column_not_null :name
      set_column_not_null :basic_cost
      set_column_not_null :cost_per_km
      add_constraint(:check_basic_cost_value) { basic_cost >= 0 }
      add_constraint(:check_cast_per_km_value) { cost_per_km >= 0 }
      add_index Sequel.function(:lower, :name), unique: true
    end
  end

  down do
    alter_table :taxes do
      set_column_allow_null :name
      set_column_allow_null :basic_cost
      set_column_allow_null :cost_per_km
      drop_constraint(:check_basic_cost_value)
      drop_constraint(:check_cast_per_km_value)
      drop_index Sequel.function(:lower, :name)
    end
  end
end
