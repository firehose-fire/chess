class RenameUserIdBlackInGames < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :user_id_black, :user_black_id
  end
end
