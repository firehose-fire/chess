class Bishop < Piece
    
  def valid_move?(to_coordinate_x, to_coordinate_y)
    if is_diagonal_move?(to_coordinate_x, to_coordinate_y) == true
       is_obstructed?(to_coordinate_x-1, to_coordinate_y-1) == true ? false : true 
       true 
    else
      false         
    end
  end

end
