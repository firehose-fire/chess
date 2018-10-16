class AddEnPassantToPiece < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :en_passant, :boolean
  end
end
