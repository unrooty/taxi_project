# Remove car status table
class RemoveCarStatusTableFromSchema < ActiveRecord::Migration[5.0]
  def change
    drop_table :car_statuses, force: :cascade
    remove_column :cars, :car_status_id
    remove_column :cars, :free
  end
end
