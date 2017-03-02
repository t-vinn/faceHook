class AddColumnToGroup < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :user_id, :string
  end
end
