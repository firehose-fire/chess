class Pawn < Piece

  attr_accessor :has_moved
  
  def horizontal_move?(x)
    x_move = (x - coordinate_x).abs
    x_move != 0
  end
  
  def move_up?(y)
    (y - coordinate_y).abs > coordinate_y
  end
 
  def move_down?(y)
    (y - coordinate_y).abs < coordinate_y
  end
  
  def move_one_space?(x, y)
    (x - coordinate_x).abs < 1 && (y - coordinate_y).abs == 1 
  end
  
  def move_two_spaces?(x, y)
    (x - coordinate_x).abs < 1 && (y - coordinate_y).abs == 2 && @has_moved != true
  end
  
  def single_diagonal_move?(x, y)
    (x - coordinate_x).abs == 1 && (y - coordinate_y).abs == 1
  end
  
  def capture_diagonal?(x, y)
    if check_diaganol(x, y) && single_diagonal_move?(x, y)
      move_to!(x, y)
    end
  end

  def in_passing? 
    #to be worked on later
  end

  def pawn_valid_move?(x, y)
    return false if is_occupied?(x, y) ||
                    is_obstructed?(x, y) ||
                    horizontal_move?(x) ||
                    move_down?(y) && piece_color == 'black' ||
                    move_up?(y) && piece_color == 'white'
    move_one_space?(x, y) || move_two_spaces?(x, y) || capture_diagonal?(x, y)
  end

 

  def move_to!(new_x, new_y)
    # how super works: go to the Piece class - execute the move_to! method and when complete
    # execute any new code we have here.
    super(new_x, new_y)
    @has_moved = true
  end

end
