class RemovePictureFromFeeds < ActiveRecord::Migration[5.0]
  def change
    remove_column :feeds, :picture, :string
  end
end
