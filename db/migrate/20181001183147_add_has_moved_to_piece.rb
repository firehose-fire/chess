class AddHasMovedToPiece < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :has_moved, :boolean
  end
end
