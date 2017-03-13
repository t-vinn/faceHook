class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_allowed, :boolean, default: true, null: false
  end
end
