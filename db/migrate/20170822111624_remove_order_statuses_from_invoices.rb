# Removing a foreign key order_status from invoices database table.
class RemoveOrderStatusesFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :invoices, :order_statuses
  end
end
