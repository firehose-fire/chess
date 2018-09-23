class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
      if is_vertical_move?(to_coordinate_x, to_coordinate_y) || is_horizontal_move?(to_coordinate_x, to_coordinate_y)
          is_obstructed?(to_coordinate_x, to_coordinate_y) == true ? false : true          
      else
        false         
      end

  end

end
