# Add route column to order
class AddRouteToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :route, :string
  end
end
