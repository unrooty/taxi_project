Sequel.migration do
  up do
    alter_table :invoices do
      set_column_not_null :distance
      set_column_default :distance, 0
      set_column_not_null :total_price
      set_column_default :total_price, 0
      set_column_not_null :order_id
      add_constraint(:check_distance_value) { distance >= 0 }
      add_constraint(:check_total_price_value) { total_price >= 0 }
      add_constraint(:check_payed_amount_value) { payed_amount >= 0 }
    end
  end

  down do
    alter_table :invoices do
      set_column_allow_null :distance
      set_column_default :distance, nil
      set_column_allow_null :total_price
      set_column_default :total_price, nil
      set_column_allow_null :order_id
      drop_constraint(:check_distance_value)
      drop_constraint(:check_total_price_value)
      drop_constraint(:check_payed_amount_value)
    end
  end
end
