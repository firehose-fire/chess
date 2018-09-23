class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
      is_vertical_move? = to_coordinate_y > 0 && (coordinate_x - to_coordinate_x).abs == 0
      is_horizontal_move? = to_coordinate_x > 0 && (coordinate_y - to_coordinate_y).abs == 0 
  
      if is_vertical_move? || is_horizontal_move?
          is_obstructed?(to_coordinate_x, to_coordinate_y) == true ? false : true          
      else
        false         
      end

  end

end
