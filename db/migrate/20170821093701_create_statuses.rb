# Initial database table for status model.
class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :title
      t.timestamps
    end
  end
end
