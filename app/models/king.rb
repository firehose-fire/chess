class King < Piece


  def valid_move?(to_coordinate_x, to_coordinate_y)
    # king piece for testing
    @king = King.new(coordinate_x: 3, coordinate_y: 0, game_id: 100, id: 1, user_id: 1)

    # king piece for production
    # @king = King.where(:user_id => 1)
    

    #this method for determining validity works for king.
    if (@king.coordinate_x - to_coordinate_x).abs <= 1 && (@king.coordinate_y - to_coordinate_y).abs <= 1
        return true
      end
        
        return false

    #this method works for king, it may work better for more complicated movements
    
    # moves = [[@king.coordinate_x + 1, @king.coordinate_y + 1], [@king.coordinate_x + 1, @king.coordinate_y ],[@king.coordinate_x + 1, @king.coordinate_y - 1],[@king.coordinate_x, @king.coordinate_y + 1],[@king.coordinate_x , @king.coordinate_y - 1],[@king.coordinate_x - 1, @king.coordinate_y + 1],[@king.coordinate_x - 1, @king.coordinate_y],[@king.coordinate_x - 1, @king.coordinate_y - 1]]
    
    # moves.each do |move|
    #   puts "Move: #{move} to coordinate_x:#{to_coordinate_x} coordinate_y:#{to_coordinate_y}"
    #   if to_coordinate_x == move[0] && to_coordinate_y == move[1]
    #     return true
    #   end
    # end
    #   return false
    
  end

end
