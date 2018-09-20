class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
      #check vertical move
      
      to_coordinate_y < 8 && (coordinate_x - to_coordinate_x).abs == 0 || to_coordinate_x < 8 && (coordinate_y - to_coordinate_y).abs == 0 
      

  end

end
