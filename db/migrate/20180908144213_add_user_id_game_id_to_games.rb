class AddUserIdGameIdToGames < ActiveRecord::Migration[5.0]
  def 
    add_column :games, :game_id, :integer
    add_column :games, :user_id_white, :integer
    add_column :games, :user_id_black, :integer
    add_column :games, :user_winner, :string
    add_index :games, :game_id

  end
end
