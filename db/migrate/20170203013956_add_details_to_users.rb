class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false, unique: true
    add_column :users, :birth_date, :date
  end
end
