class AddIndexToSimilaritiesUsers < ActiveRecord::Migration[5.0]
  def change
    add_index  :similarities_users, [:user_id, :similarity_id], unique: true
  end
end
