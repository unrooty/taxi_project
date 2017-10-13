# Remove order status table
class RemoveOrderStatusTableFromSchema < ActiveRecord::Migration[5.0]
  def change
    drop_table :order_statuses, force: :cascade
    remove_column :orders, :order_status_id
    remove_column :orders, :client_id
    remove_column :orders, :dispatcher_id
  end
end
