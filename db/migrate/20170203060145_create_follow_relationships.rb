class CreateFollowRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_relationships do |t|
      t.integer :follower_user_id, null: false
      t.integer :followee_user_id, null: false

      t.timestamps
    end
  end
end
