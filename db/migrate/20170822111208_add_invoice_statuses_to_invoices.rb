# Adding a foreign key invoice_status to invoices database table.
class AddInvoiceStatusesToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :invoices, :invoice_statuses
  end
end
