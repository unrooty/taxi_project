# Remove employees table from schema
class DropEmployees < ActiveRecord::Migration[5.0]
  def change
    drop_table :employees, force: :cascade
  end
end
