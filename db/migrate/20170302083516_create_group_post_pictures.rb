class CreateGroupPostPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :group_post_pictures do |t|
      t.integer :group_post_id, null: false
      t.string :picture, null: false

      t.timestamps
    end
  end
end
