class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
      #check vertical move
          if to_coordinate_y > 0 && (coordinate_x - to_coordinate_x).abs == 0 
        true
      #check horizontal move
      elsif to_coordinate_x < 8 && (coordinate_y - to_coordinate_y).abs == 0 
        true
      else
        false
      end

      

  end

end
