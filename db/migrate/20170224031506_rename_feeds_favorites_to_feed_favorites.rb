class RenameFeedsFavoritesToFeedFavorites < ActiveRecord::Migration[5.0]
  def change
    rename_table :feeds_favorites, :feed_favorites
  end
end
