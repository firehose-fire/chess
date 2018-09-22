class Queen < Piece

  def valid_move?(x_target, y_target)
    is_obstructed?(x_target, y_target) ? true : false
  end
end
