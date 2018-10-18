class Bishop < Piece
    
  def valid_move?(to_coordinate_x, to_coordinate_y)
    if is_diagonal_move?(to_coordinate_x, to_coordinate_y) == true 

       is_obstructed?(to_coordinate_x, to_coordinate_y) == true ? false : true 
        
    else
      false         
    end
  end

end
