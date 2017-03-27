class CreateSimilarities < ActiveRecord::Migration[5.0]
  def change
    create_table :similarities do |t|
      t.integer :similarity, null: false

      t.timestamps
    end
  end
end
