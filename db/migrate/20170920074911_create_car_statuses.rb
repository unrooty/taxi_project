# Create car statuses table
class CreateCarStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :car_statuses do |t|
      t.string :title

      t.timestamps
    end
  end
end
