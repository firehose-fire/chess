class Pawn < Piece

  attr_accessor :has_moved

  def move_one_space?(x, y)
    (x - coordinate_x).abs < 1 && (y - coordinate_y).abs == 1
  end

  def move_two_spaces?(x, y)
    (x - coordinate_x).abs < 1 && (y - coordinate_y).abs == 2 unless has_moved == true
  end

  def capture_diagonal?(x, y)
    # if the opposing player's piece is located at a direct diagonal can be captured
    # ex1. this piece is at [2,3] and opposing piece is at [3,4] or [1,4]
    # ex2. this piece is at [3,5] and opposing piece is at [2,4] or [4,4]
     
  end

  def no_capture_vertical(x, y)

  end

  def move_to!(new_x, new_y)
    # how super works: go to the Piece class - execute the move_to! method and when complete
    # execute any new code we have here.
    super(new_x, new_y)
    @has_moved = true
  end

end
