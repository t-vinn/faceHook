class AddIndexToGroupPostFavorites < ActiveRecord::Migration[5.0]
  def change
    add_index  :group_post_favorites, [:user_id, :group_post_id], unique: true
  end
end
