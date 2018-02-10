Sequel.migration do
  up do
    alter_table :invoices do
      set_column_type :invoice_status, String
      set_column_default :invoice_status, 'Unpaid'
    end
  end

  down do
    alter_table :invoices do
      set_column_type :invoice_status, Integer
      set_column_default :invoice_status, 0
    end
  end
end
