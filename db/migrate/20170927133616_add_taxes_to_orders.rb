# Add tax_id column and foreign key to orders
class AddTaxesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :tax_id, :integer, default: 0, null: false
    add_foreign_key :orders, :taxes
  end
end
