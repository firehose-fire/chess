class Queen < Piece


  def valid_move?(x_target, y_target)

    if is_diagonal_move?(x_target, y_target) || is_horizontal_move?(x_target, y_target) || is_vertical_move?(x_target, y_target)
      value = is_obstructed?(x_target, y_target)
      value == true ? false : true
    # else
    #   false
    end

  end
end
