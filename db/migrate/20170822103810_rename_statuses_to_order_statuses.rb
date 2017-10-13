# Renaming statuses database table to order_statuses
class RenameStatusesToOrderStatuses < ActiveRecord::Migration[5.0]
  def change
    rename_table :statuses, :order_statuses
  end
end
