# Rename route column to end point
class RenameRouteToEndPoint < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :route, :end_point
  end
end
