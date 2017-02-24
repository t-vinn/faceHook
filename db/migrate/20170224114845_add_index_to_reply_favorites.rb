class AddIndexToReplyFavorites < ActiveRecord::Migration[5.0]
  def change
    add_index :reply_favorites, [:reply_id, :user_id], unique: true
  end
end
