class ChangeColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :notification_allowed, :boolean, default: false, null: false
  end
end
