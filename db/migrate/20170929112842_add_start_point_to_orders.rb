# Add start point column to orders
class AddStartPointToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :start_point, :string
  end
end
