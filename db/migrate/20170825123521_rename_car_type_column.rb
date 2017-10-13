# Rename type column to style
class RenameCarTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :cars, :type, :style
  end
end
