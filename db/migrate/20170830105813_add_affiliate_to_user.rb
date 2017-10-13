# Add affiliate_id column to users
class AddAffiliateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :affiliate_id, :integer
  end
end
