class AddNullFalseToPiece < ActiveRecord::Migration[5.0]
  def change
    change_column :pieces, :has_moved, :boolean, :default => false, :null => false
  end
end
