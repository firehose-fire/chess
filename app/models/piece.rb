class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def is_occupied?(x,y)
    # search the pieces database and see if x, y are occupied 
    game.pieces.where(coordinate_x: x, coordinate_y: y).present?
  end

# Define method using x and y target coordinates to see if move is horizontal
  def is_path_horizontal?(x_position_change, y_target)
      (1..x_position_change.abs).each do |x|
        return true if is_occupied?(x, y_target)
      end
  end

  # Define method using x and y target coordinates to see if move is vertical
  def is_path_vertical?(x_target, y_position_change)
      (1..y_position_change.abs).each do |y|
        return true if is_occupied?(x_target, y)
      end
  end

  # Define method using x and y target coordinates to see if move is diaganol
  def is_path_diaganol?(x_position_change, y_position_change)
      ((1..x_position_change)).each do |x|
        ((1..y_position_change)).each do |y|
          return true if is_occupied?(x, y)
        end
      end
  end

# Define method using x and y target coordinates to see if move is outside of the defined game board
  def is_path_valid?(x_target, y_target)
    if x_target > 7 || x_target < 0 || y_target > 7 || y_target < 0
      return "invalid path"
    end
  end

  def is_obstructed?(x_origin, y_origin, x_target, y_target)
    x_position_change = (x_target - x_origin).abs
    y_position_change = (y_target - y_origin).abs

    # is the path valid
    if is_path_valid?(x_target, y_target)
      return "Out of bounds of box"
    # is the path horizontal
    elsif x_position_change > 0 && y_position_change == 0
      is_path_horizontal?(x_position_change, y_target)
    # is the path vertical
    elsif x_position_change == 0 && y_position_change > 0
      is_path_vertical?(x_target, y_position_change)
    # is the path diaganol
    elsif x_position_change == (y_position_change)
      is_path_diaganol?(x_position_change, y_position_change) 
    end
  end

end
