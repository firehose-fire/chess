class RemovePieceIdFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :piece_id, :integer
  end
end
