class King < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
   
    (coordinate_x - to_coordinate_x).abs <= 1 && (coordinate_y - to_coordinate_y).abs <= 1
    
  end

end
