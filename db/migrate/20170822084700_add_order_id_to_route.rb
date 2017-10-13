# Adding order_id column to routes table.
class AddOrderIdToRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :routes, :order_id, :integer
  end
end
