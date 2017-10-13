# Add indebtedness column to invoice table
class AddIndebtednessToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :indebtedness, :decimal
  end
end
