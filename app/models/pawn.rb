class Pawn < Piece 

  def horizontal_move?(x)
    x_move = (x - coordinate_x).abs
    x_move != 0
  end

  def move_up?(x, y)
    (y - coordinate_y) > 0 && piece_color == 'black'
  end

  def move_down?(x, y)
    (y - coordinate_y) < 0 && piece_color == 'white'
  end
  
  def move_one_space?(x, y)
    if move_up?(x, y) || move_down?(x, y)
      (x - coordinate_x).abs.zero? && (y - coordinate_y).abs == 1
    else
      false
    end
  end
  
  def move_two_spaces?(x, y)
    if move_up?(x, y) || move_down?(x, y)
      (x - coordinate_x).abs.zero? && (y - coordinate_y).abs == 2 && has_moved != true
    else
      false
    end
  end

  def en_passant?(y)
    has_moved != true ? (y - coordinate_y).abs == 2 : false
  end
  
  def single_diagonal_move?(x, y)
    (x - coordinate_x).abs == 1 && (y - coordinate_y).abs == 1
  end
  
  def capture_diagonal?(x, y)
    check_diaganol(x, y) && single_diagonal_move?(x, y)
  end

  
  def valid_move?(x, y)
    return false if horizontal_move?(x) && !check_diaganol(x, y)
    return false if is_occupied?(x, y) && !check_diaganol(x, y)
    return false if is_obstructed?(x, y) && !check_diaganol(x, y)
    if type == 'Pawn' && en_passant?(y)
      update_attributes(en_passant: true)
    else
      update_attributes(en_passant: false)
    end
    move_one_space?(x, y) || move_two_spaces?(x, y) || capture_diagonal?(x, y)

  end
end
