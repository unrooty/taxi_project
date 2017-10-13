# Initial database table for route model.
class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :departure_address
      t.string :arrival_address
      t.timestamps
    end
  end
end
