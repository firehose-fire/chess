class Piece < ApplicationRecord

  belongs_to :game , optional: true
  belongs_to :user , optional: true

#   def is_occupied?(x,y)
#     # search the pieces database and see if x, y are occupied 
#     @piece = Piece.where(coordinate_x: x, coordinate_y: y).present?
#   end

# # Define method using x and y target coordinates to see if move is horizontal
#   def check_horizontal(x_target, y_target)

   
#       ((coordinate_x + 1)..(x_target - 1)).each do |x|
#         return true if is_occupied?(x, y_target)
#       end
#         return false    
#   end

#   # Define method using x and y target coordinates to see if move is vertical
#   def check_vertical(x_target, y_position_change)
#       (coordinate_y..y_position_change.abs - 1).each do |y|
#         return true if is_occupied?(x_target, y)
#       end
#         return false
#   end

#   # Define method using x and y target coordinates to see if move is diaganol
#   def check_diaganol(x_position_change, y_position_change)
#       ((1..x_position_change)).each do |x|
#         ((1..y_position_change)).each do |y|
#           return true if is_occupied?(x, y)
#         end
#           return false
#       end
#   end

# # Define method using x and y target coordinates to see if move is outside of the defined game board
#   def is_path_valid?(x_target, y_target)
#     if x_target > 7 || x_target < 0 || y_target > 7 || y_target < 0
#       return "invalid path"
#     end
#   end

#   def is_obstructed?(x_target, y_target)
#     x_position_change = (x_target - coordinate_x).abs
#     y_position_change = (y_target - coordinate_y).abs

#     # is the path valid
#     if is_path_valid?(x_target, y_target)
#     # is the path horizontal
#     elsif x_position_change > 0 && y_position_change == 0
#       check_horizontal(x_target, y_target)
#     # is the path vertical
#     elsif x_position_change == 0 && y_position_change > 0
#       check_vertical(x_target, y_position_change)
#     # is the path diaganol
#     elsif x_position_change == (y_position_change)
#       check_diaganol(x_position_change, y_position_change) 
#     end
#   end

#-----------------------------------------
# jesse's code


  def is_occupied?(x,y)
    # search the pieces database and see if x, y are occupied 
      @piece = Piece.where(coordinate_x: x,  coordinate_y: y).present?
    
  end

# Define method using x and y target coordinates to see if move is horizontal
  def check_horizontal(x_target, y_target)
    #left to right
    if coordinate_x < x_target
      (coordinate_x+1..x_target-1).each do |x|
        return true if is_occupied?(x, y_target)
      end
        return false
    end
    #righ to left
    if x_target < coordinate_x
      (x_target+1..coordinate_x-1).each do |x|
        return true if is_occupied?(x, y_target)
      end
        return false
    end


  end

  # Define method using x and y target coordinates to see if move is vertical
  def check_vertical(x_target, y_target)
    #bottom to top
      if coordinate_y < y_target
      (coordinate_y+1..y_target-1).each do |y|
        return true if is_occupied?(x_target, y)
      end
        return false
    end
    #top to bottom
    if y_target < coordinate_y
      (y_target+1..coordinate_y-1).each do |y|
        return true if is_occupied?(x_target, y)
      end
        return false
    end

  end

  # Define method using x and y target coordinates to see if move is diaganol
  def check_diaganol(x_target, y_target)
    


  end



  def is_obstructed?(x_target, y_target)
    x_position_change = (x_target - coordinate_x).abs
    y_position_change = (y_target - coordinate_y).abs

    # is the path valid
   if x_target > 7 || x_target < 0 || y_target > 7 || y_target < 0
    return false 
   end

      
    
    # is the path horizontal
    if  y_position_change == 0 && x_position_change > 0
      # puts "I'm moving horizontal"
     check_horizontal(x_target, y_target)
    
    # is the path vertical
    elsif x_position_change == 0 && y_position_change > 0

      check_vertical(x_target, y_target)
    # is the path diaganol
    elsif x_position_change == y_position_change
      check_diaganol(x_target, y_target) 
    end

  end


def captured?(new_x, new_y)
    target_move = Piece.where(coordinate_x: new_x, coordinate_y: new_y).first

    if defined?(target_move.user_id)
      if(target_move.user_id == self.user_id)
        raise RuntimeError
      else
        target_move.update_attributes(coordinate_x: nil, coordinate_y: nil, captured: true)
      end
    end

  end


  def move_to!(new_x, new_y)
    captured?(new_x, new_y) ? nil : update_attributes(coordinate_x: new_x, coordinate_y: new_y)
  end

end
