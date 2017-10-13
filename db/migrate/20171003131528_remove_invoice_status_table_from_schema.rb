# Remove invoice status table
class RemoveInvoiceStatusTableFromSchema < ActiveRecord::Migration[5.0]
  def change
    drop_table :invoice_statuses, force: :cascade
    remove_column :invoices, :invoice_status_id
  end
end
