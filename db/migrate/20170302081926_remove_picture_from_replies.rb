class RemovePictureFromReplies < ActiveRecord::Migration[5.0]
  def change
    remove_column :replies, :picture, :string
  end
end
