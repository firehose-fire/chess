class Queen < Piece

  def valid_move?(x_target, y_target)

    if is_diagonal_move?(x_target, y_target) || is_horizontal_move?(x_target, y_target) || is_vertical_move?(x_target, y_target)
         return is_obstructed?(x_target, y_target)
    end

  end
end
