class AddNotificationAllowedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_allowed, :boolean, default: false, null: false
  end
end
