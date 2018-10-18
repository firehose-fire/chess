class Rook < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
    
      if is_vertical_move?(to_coordinate_x, to_coordinate_y) || is_horizontal_move?(to_coordinate_x, to_coordinate_y)
          is_obstructed?(to_coordinate_x, to_coordinate_y) == true ? false : true          
      else
        false         
      end

  end
 
    
  def can_castle?
    if self.piece_color == "white"
  
      white_king = Piece.where(type: "King", game_id: game_id, piece_color: "white").first
      return white_king.has_moved != true && 
      white_king.is_obstructed?(self.coordinate_x, self.coordinate_y) == false && 
      self.has_moved != true
    elsif self.piece_color == "black"
      black_king = Piece.where(type: "King", game_id: game_id, piece_color: "black").first
      return black_king.has_moved != true && black_king.is_obstructed?(self.coordinate_x, self.coordinate_y) == false && self.has_moved != true
    else
      return false
    end
  end

    
  def castle_queenside!
    if can_castle?
      if self.piece_color == "white"
        # move rook queenside
        self.update_attributes(coordinate_x: 3, coordinate_y: 7)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, has_moved: false).first
        white_king.update_attributes(coordinate_x: 2, coordinate_y: 7)
      else
        # move rook queenside
        self.update_attributes(coordinate_x: 3, coordinate_y: 0)
        # move king
        black_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 0, has_moved: false).first
        black_king.update_attributes(coordinate_x: 2, coordinate_y: 0)
      end
    end
  end
        
  def castle_kingside!
    if can_castle?
      if self.piece_color == "white"
        # move rook queenside
        self.update_attributes(coordinate_x: 5, coordinate_y: 7)
        # move king
        white_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 7, has_moved: false).first
        white_king.update_attributes(coordinate_x: 6, coordinate_y: 7)
      else
        # move rook queenside
        self.update_attributes(coordinate_x: 5, coordinate_y: 0)
        # move king
        black_king = Piece.where(type: "King", game_id: game_id, coordinate_x: 4, coordinate_y: 0, has_moved: false).first
        black_king.update_attributes(coordinate_x: 6, coordinate_y: 0)
      end
    end
  end


end
