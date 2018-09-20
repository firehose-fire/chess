class Knight < Piece

  def valid_move?(to_coordinate_x, to_coordinate_y)
      (coordinate_x - to_coordinate_x).abs == 2 && (coordinate_y - to_coordinate_y).abs == 1 || (coordinate_x - to_coordinate_x).abs == 1 && (coordinate_y - to_coordinate_y).abs == 2

  end

end
