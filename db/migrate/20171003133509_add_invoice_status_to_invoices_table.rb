# Add invoice status column to invoice table
class AddInvoiceStatusToInvoicesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :invoice_status, :integer, default: 0, null: false
  end
end
