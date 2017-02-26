class ChangeColumnToGroups < ActiveRecord::Migration[5.0]
  def change
    change_column_null :groups, :owner_user_id, false
  end
end
