# Adding order_id column to invoices table.
class AddOrderIdToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :order_id, :integer
  end
end
