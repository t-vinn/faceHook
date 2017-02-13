class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.integer :user_id, null: false
      t.string :content, null: false
      t.integer :privacy, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
