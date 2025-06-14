class AddIndexesForReports < ActiveRecord::Migration[7.1]
  def change
    add_index :companies, :name, unique: true
    add_index :users, :username, unique: true
    add_index :tweets, :created_at
    add_index :tweets, [:user_id, :created_at]
  end
end