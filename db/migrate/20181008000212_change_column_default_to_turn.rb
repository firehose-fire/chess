class ChangeColumnDefaultToTurn < ActiveRecord::Migration[5.0]
  def change
    change_column_default :games, :turn, from: nil, to: true
  end
end
