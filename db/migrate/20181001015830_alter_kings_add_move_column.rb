class AlterKingsAddMoveColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :kings, :move, :boolean, :default => false
  end
end
