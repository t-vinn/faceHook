class AddPictureToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :picture, :string
  end
end
