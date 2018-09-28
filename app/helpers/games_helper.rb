module GamesHelper

  def piece_image(type, color)
    image_tag "#{color}-#{type}.svg"
  end

  # Find all of the squares that do not have pieces in them!

  def get_piece_at_click(pieces, row, column)
    pieces.find do |piece|
      piece_in_row_and_column?(piece, row, column)    
    end
  end

  # Find all of the squares that do not have pieces in them!

  def piece_in_row_and_column?(piece, row, column)
    piece && row == piece.coordinate_x && column == piece.coordinate_y      
  end

  def link_to_piece(piece)
    link_to 'piece', piece_path(piece) if piece
  end

end
