# Add default value to payed amount and indebtedness
class AddDefaultsToInvoice < ActiveRecord::Migration[5.0]
  def change
    change_column :invoices, :payed_amount, :decimal, default: 0, null: false
    change_column :invoices, :indebtedness, :decimal, default: 0, null: false
  end
end
