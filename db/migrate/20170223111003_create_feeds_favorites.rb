class CreateFeedsFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds_favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :feed, foreign_key: true, null: false

      t.timestamps
    end
  end
end
