class AlterPiecesAddMoveColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :move, :boolean
  end
end
