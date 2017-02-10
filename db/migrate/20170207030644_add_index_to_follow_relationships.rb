class AddIndexToFollowRelationships < ActiveRecord::Migration[5.0]
  def change
    add_index :follow_relationships, [:follower_user_id, :followee_user_id], unique: true, :name =>'follow_relationship_users_index'
  end
end
