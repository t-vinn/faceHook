class AddColumnToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :owner_user_id, :integer
  end
end
