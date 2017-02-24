class AddIndexToFeedFavorites < ActiveRecord::Migration[5.0]
  def change
    add_index :feed_favorites, [:user_id, :feed_id], unique: true
  end
end
