# Deleting invoice_id column from orders table.
class DeleteInvoiceIdFromOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :invoice_id
  end
end
