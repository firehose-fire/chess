class RemoveUserIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_id, :integer
  end
end
