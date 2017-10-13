# Initial database table for order model.
class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.integer :route_id
      t.integer :car_id
      t.integer :dispatcher_id
      t.integer :invoice_id
      t.integer :status_id
      t.timestamps
    end
    add_foreign_key :orders, :clients
    add_foreign_key :orders, :routes
    add_foreign_key :orders, :invoices
    add_foreign_key :orders, :statuses
  end
end
