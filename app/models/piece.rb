class Piece < ApplicationRecord
  attr_accessor :has_moved

  belongs_to :game, optional: true
  belongs_to :user, optional: true
  
  def captured!(new_x, new_y)
    target_move = Piece.where(game_id: game_id, coordinate_x: new_x, coordinate_y: new_y).first
    if defined?(target_move.piece_color)
      if(target_move.piece_color == piece_color)
        raise RuntimeError
      else
        target_move.update_attributes(coordinate_x: nil, coordinate_y: nil, captured: true)
      end
    end

  end

  def is_capture_valid?(new_x, new_y)
    target_piece = Piece.where(game_id: game_id, coordinate_x: new_x, coordinate_y: new_y).first
    (!target_piece || target_piece.user == self.user) ? false : true
  end

  def move_to!(new_x, new_y)
    return false if boundaries(new_x,new_y) == false    
    return false if piece_color == 'white' && game.turn == true
    return false if piece_color == 'black' && game.turn == false
    return false if valid_move?(new_x, new_y) == false
    captured!(new_x, new_y)
    update_attributes(coordinate_x: new_x, coordinate_y: new_y, has_moved: true)
    game.toggle_turn

  end

  # check move is within board boundaries
  def boundaries(x, y)
    return false if x > 7 || x < 0 || y > 7 || y < 0
    return true

  end

  def is_occupied?(x, y)
    # search the pieces database and see if x, y are occupied 
    @piece = Piece.where(game_id: game_id, coordinate_x: x, coordinate_y: y)
    @piece.present?
  end


  def is_diagonal_move?(x_target, y_target)
    if (self.coordinate_x - x_target).abs == (self.coordinate_y - y_target).abs
      return true
    end
    false
  end

  def is_vertical_move?(x_target, y_target)
    if self.coordinate_x == x_target && self.coordinate_y != y_target
      return true
    end
    false
  end

  def is_horizontal_move?(x_target, y_target)
    if self.coordinate_x != x_target && self.coordinate_y == y_target
      return true
    end
    false
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

    x = coordinate_x
    y = coordinate_y
                

    #top to bottom and left to right
    if x < x_target and y > y_target
      while x < x_target do 
        x = x + 1 
        y = y - 1

        return true if is_occupied?(x, y) == true
      end
    end

    #top to bottom and right to left
    if x > x_target and y > y_target
      while x > x_target do 
        
        x = x - 1 
        y = y - 1
        return true if is_occupied?(x, y)
        
      end
    end

    #bottom to top and right to left
    if x > x_target and y < y_target
      while x > x_target do 
        x = x - 1 
        y = y + 1
        
        return true if is_occupied?(x, y)
      end
    end

    #bottom to top and left to right
    if x < x_target and y < y_target
      while x < x_target do 
        x = x + 1 
        y = y + 1
        return true if is_occupied?(x, y)
      end
    end

    return false
  end
  

  def is_obstructed?(x_target, y_target)
    x_position_change = (x_target - coordinate_x).abs
    y_position_change = (y_target - coordinate_y).abs
    # is the path valid
   if boundaries(x_target,y_target) == false
    puts "#{self.inspect} moving to #{x_target}, #{y_target}"
    raise 'Outside of bounds of game'
   end

    # is the path horizontal
    if  y_position_change == 0 && x_position_change > 0

     check_horizontal(x_target, y_target)
    
    # is the path vertical
    elsif x_position_change == 0 && y_position_change > 0

      check_vertical(x_target, y_target)

    # is the path diaganol
    elsif x_position_change == y_position_change

      check_diaganol(x_target, y_target) 

    else    
      # puts "Error: Invalid Move #{self.piece_color} #{self.type} at #{self.coordinate_x}, #{self.coordinate_y} "
      # puts "#{self.inspect}"
      return false
      # raise "Error Invalid move"
    end

  end  

end




