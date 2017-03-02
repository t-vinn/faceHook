class CreateFeedPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_pictures do |t|
      t.integer :feed_id, null: false
      t.string :picture, null: false

      t.timestamps
    end
  end
end
