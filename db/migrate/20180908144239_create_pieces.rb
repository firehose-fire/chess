class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :piece_id
      t.integer :coordinate_x 
      # columns 0-7
      t.integer :coordinate_y
      # rows A-H represented as 0-7
      t.string :piece_type
      # Pawn, rook, etc.
      t.string :piece_color
      #B / W
      t.boolean :captured
      t.timestamps
    end
  end
end
