class CreateGroupPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :group_posts do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
