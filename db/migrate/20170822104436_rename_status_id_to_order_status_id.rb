# Renaming orders column status_id to order_status_id
class RenameStatusIdToOrderStatusId < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :status_id, :order_status_id
  end
end
