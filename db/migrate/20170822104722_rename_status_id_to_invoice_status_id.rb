# Renaming invoices column status_id to invoice_status_id
class RenameStatusIdToInvoiceStatusId < ActiveRecord::Migration[5.0]
  def change
    rename_column :invoices, :status_id, :invoice_status_id
  end
end
