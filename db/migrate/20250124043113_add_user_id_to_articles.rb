class AddUserIdToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :user_id, :integer
    add_index :articles, :user_id # Add an index for faster lookup
  end
end
