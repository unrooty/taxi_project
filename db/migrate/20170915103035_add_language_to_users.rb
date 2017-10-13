# Add language column to users
class AddLanguageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :language, :integer, default: 0, null: false
  end
end
