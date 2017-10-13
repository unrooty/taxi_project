# Remove clients table from schema
class DropClients < ActiveRecord::Migration[5.0]
  def change
    drop_table :clients, force: :cascade
  end
end
