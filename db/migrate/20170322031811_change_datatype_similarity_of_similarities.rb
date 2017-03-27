class ChangeDatatypeSimilarityOfSimilarities < ActiveRecord::Migration[5.0]
  def change
    change_column :similarities, :similarity, :float, default: 0, null: false
  end
end
