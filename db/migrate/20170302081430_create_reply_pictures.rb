class CreateReplyPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :reply_pictures do |t|
      t.integer :reply_id, null: false
      t.string :picture, null: false

      t.timestamps
    end
  end
end
