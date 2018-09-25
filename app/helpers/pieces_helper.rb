module PiecesHelper

# need to build out helpers to move to squares

  def link_to_square(row, column)
    get_square_at_click(row, column)
  end

  def get_square_at_click(row, column)
    square = []
    square.each do |row|
      @square_x = row
      square.each do |column|
        @square_y = columm
      end
    end
  end

  def move_to_square?(square, piece, row, column)
    square && row == piece.coordinate_x && column == piece.coordinate_y      
  end

  def not_selected_square(get_square_at_click)
    link_to 'piece', piece_path(piece) if piece                                                           
  end

  def link_to_square(row, column)
    link_to 'square', piece_path(@selected_piece)
  end

end
