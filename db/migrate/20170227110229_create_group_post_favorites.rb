class CreateGroupPostFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :group_post_favorites do |t|
      t.integer :user_id, null: false
      t.integer :group_post_id, null: false

      t.timestamps
    end
  end
end
