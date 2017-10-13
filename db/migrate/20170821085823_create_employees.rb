# Create employees table
class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :type
      t.references :affiliate, foreign_key: true

      t.timestamps
    end
  end
end
