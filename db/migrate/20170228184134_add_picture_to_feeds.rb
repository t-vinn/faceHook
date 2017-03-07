class AddPictureToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :picture, :string
  end
end
