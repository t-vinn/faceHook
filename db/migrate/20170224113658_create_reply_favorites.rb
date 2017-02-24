class CreateReplyFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :reply_favorites do |t|
      t.integer :reply_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
