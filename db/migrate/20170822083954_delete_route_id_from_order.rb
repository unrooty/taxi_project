# Deleting route_id column from orders table.
class DeleteRouteIdFromOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :route_id
  end
end
