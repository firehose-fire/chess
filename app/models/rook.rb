class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
    
      if is_vertical_move?(to_coordinate_x, to_coordinate_y) || is_horizontal_move?(to_coordinate_x, to_coordinate_y)
          is_obstructed?(to_coordinate_x, to_coordinate_y) == true ? false : true          
      else
        false         
      end

  end
 

  def castle!
    if can_castle_kingside?
      castle_kingside!
    elsif can_castle_queenside?
      castle_queenside!
    else
      raise "Error, invalid castling." 
    end 
  end
    
  # castle
  def can_castle?
    if self.color == "white"
      white_king = Piece.where(type: "King", game_id: game_id, color: "white")
      return white_king.move == false && white_king.is_obstructed?(self.coordinate_x, self.coordinate_y) == false && self.move == false
    else
      black_king = Piece.where(type: "King", game_id: game_id, color: "black")
      return black_king.move == false && black_king.is_obstructed?(self.coordinate_x, self.coordinate_y) == false && self.move == false
    end  
  end

    
  def castle_queenside!
    if can_castle?
      if self.color == "white"
        # move rook queenside
        self.update_attributes(coordinate_x: 2, coordinate_y: 7)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, move: false).first
        white_king.update_attributes(coordinate_x: 1, coordinate_y: 7)
      else
        # move rook queenside
        self.update_attributes(coordinate_x: 0, coordinate_y: 2)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, move: false).first
        white_king.update_attributes(coordinate_x: 0, coordinate_y: 1)
      end
    end
  end
        
  def castle_kingside!
    if can_castle?
      if self.color == "white"
        # move rook queenside
        self.update_attributes(coordinate_x: 5, coordinate_y: 7)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, move: false).first
        white_king.update_attributes(coordinate_x: 6, coordinate_y: 7)
      else
        # move rook queenside
        self.update_attributes(coordinate_x: 0, coordinate_y: 5)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, move: false).first
        white_king.update_attributes(coordinate_x: 0, coordinate_y: 6)
      end
    end
  end
      


end
