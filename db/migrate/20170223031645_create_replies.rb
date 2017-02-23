class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.references :user, foreign_key: true, null: false
      t.references :feed, foreign_key: true, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
