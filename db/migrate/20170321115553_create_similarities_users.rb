class CreateSimilaritiesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :similarities_users do |t|
      t.integer :similarity_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
