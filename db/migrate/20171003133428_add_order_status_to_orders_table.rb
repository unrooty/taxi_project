# Add order status column to order table
class AddOrderStatusToOrdersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_status, :integer, default: 0, null: false
  end
end
