# Add client_name and client_phone to order
class AddClientInfoToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :client_name, :string
    add_column :orders, :client_phone, :string
  end
end
