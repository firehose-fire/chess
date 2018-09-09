class RenameUserIdWhiteInGames < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :user_id_white, :user_white_id
  end
end
