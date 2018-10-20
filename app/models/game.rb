
class Game < ApplicationRecord
  belongs_to :user_white, class_name: 'User', optional: true
  belongs_to :user_black, class_name: 'User', optional: true
  has_many :pieces

  after_create :populate_the_game
  
  scope :available, -> { where(user_white_id: nil) }

  attr_accessor(:king, :king_x, :king_y)

  def piece_at(x, y)
    pieces.where(coordinate_x: x, coordinate_y: y).first
  end
  
  def toggle_turn
    next_turn = !turn
    if update_attributes(turn: next_turn)
      return next_turn
    end
      nil
  end
  
  def populate_the_game 

    # Pawn creation for white and black player
    (0..7).each do |b|
      Pawn.create(coordinate_x: b, coordinate_y: 1, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    end

    (0..7).each do |w|
      Pawn.create(coordinate_x: w, coordinate_y: 6, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    end

    # King creation for white and black player
    King.create(coordinate_x: 4, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id, has_moved: false)
    King.create(coordinate_x: 4, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id, has_moved: false)

    # Bishop creation for white and black player
    Bishop.create(coordinate_x: 2, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Bishop.create(coordinate_x: 5, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Bishop.create(coordinate_x: 2, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    Bishop.create(coordinate_x: 5, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

    # Rook creation for white and black player
    Rook.create(coordinate_x: 0, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id, has_moved: false)
    Rook.create(coordinate_x: 7, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id, has_moved: false)
    Rook.create(coordinate_x: 0, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id, has_moved: false)
    Rook.create(coordinate_x: 7, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id, has_moved: false)

    # Knight creation for white and black player

    Knight.create(coordinate_x: 1, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Knight.create(coordinate_x: 6, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Knight.create(coordinate_x: 1, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    Knight.create(coordinate_x: 6, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

    # Queen creation for white and black player

    Queen.create(coordinate_x: 3, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Queen.create(coordinate_x: 3, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

  end

  def is_check?(user)
    
    if user == user_black
      @king = pieces.where(type: "King", user_id: user_black).first 
      @king_x = @king.coordinate_x
      @king_y = @king.coordinate_y
        user_white.pieces.where(game: self.id).each do |piece| 
        if piece.type != "King" 
          if is_valid_move_valid_capture?(piece, @king) == true
            @check_piece = @piece
            return true
          end 
          end 
        end
      return false
    end

    if user == user_white
      @king = pieces.where(type: "King", user_id: user_white).first
      @king_x = @king.coordinate_x
      @king_y = @king.coordinate_y   
        user_black.pieces.where(game: self.id).each do |piece|
          if piece.type != "King" 
            if is_valid_move_valid_capture?(piece, @king) == true
              @check_piece = @piece
              return true
            end 
          end
        end      
      return false
    end
  end


  def is_valid_move_valid_capture?(piece, capture_piece)   
  
        #checks if the move is valid and capture valid
      if piece.valid_move?(capture_piece.coordinate_x, capture_piece.coordinate_y) == true && piece.is_capture_valid?(capture_piece.coordinate_x, capture_piece.coordinate_y) == true                  
        @piece = piece
        return true
      end  
  
      return false
    
  end

  def capture_check?(user, check_piece)
    @check_piece = check_piece
    #can any of my pieces capture the piece that has me in check?
    user.pieces.where(game: self.id).each do |piece|
     if is_valid_move_valid_capture?(piece, check_piece) == true 
        return true 
      end
      
    end
     return false 
  end


  def can_king_move?(user)
    king_moves = [  
      [@king_x+1, @king_y+1],
      [@king_x+1, @king_y],
      [@king_x+1, @king_y-1],
      [@king_x, @king_y+1],
      [@king_x, @king_y-1],
      [@king_x-1, @king_y+1],
      [@king_x-1, @king_y],
      [@king_x-1, @king_y-1]
    ]   

        #check surrounding spaces to see if king can move to avoid checkmate      
    king_moves.each do |move| 
      #is move in bounds? is space empty? check piece cannot move to that space and capture king
      return false if king.boundaries(move[0], move[1]) == true && pieces.where(coordinate_x: move[0], coordinate_y: move[1]).first == nil && @check_piece.valid_move?(move[0],move[1]) == false 
    end
  end

  def can_block?(user, check_piece)
    #find pieces that can move to the path between the check piece and the king 
    user.pieces.where(game: self.id).each do | piece |
      if piece.type != "King" 
        # check diagonal spaces between check piece and king        
        if check_piece.is_diagonal_move?(@king.coordinate_x, @king.coordinate_y) == true 
          #find which piece is lesser and greater to seth the range check
          if check_piece.coordinate_x > @king_x
            first = @king_x+1
            last = check_piece.coordinate_x
            y_axis = @king_y+1
          elsif check_piece.coordinate_x < @king_x
            first = check_piece.coordinate_x+1
            last = @king_x
            y_axis = check_piece.coordinate_y+1
          end
        
          (first...last).each do | x_axis |
            return true if piece.valid_move?(x_axis,y_axis) == true
            y_axis+=1        
          end
        end

        if check_piece.is_horizontal_move?(@king.coordinate_x, @king.coordinate_y) == true
          
          if check_piece.coordinate_x > @king_x
            first = @king_x+1
            last = check_piece.coordinate_x
          elsif check_piece.coordinate_x < @king_x
            first = check_piece.coordinate_x+1
            last = @king_x
          end

          (first...last).each do | moving_axis |
            return true if piece.valid_move?(moving_axis,@king_y) == true
                   
          end
        end
        if check_piece.is_vertical_move?(@king.coordinate_x, @king.coordinate_y) == true
          if check_piece.coordinate_y > @king_y
            first = @king_y+1
            last = check_piece.coordinate_y
          elsif check_piece.coordinate_y < @king_y
            first = check_piece.coordinate_y+1
            last = @king_y
          end

          (first...last).each do | moving_axis |
            return true if piece.valid_move?(@king_x,moving_axis) == true
          end      

        end


      end
       
    end
    return false
  
  end

  
  def checkmate?(user)
    @user = user
    if is_check?(@user) == true
      return false if can_block?(@user, @check_piece) == true || capture_check?(@user, @check_piece) == true  ||  can_king_move?(@user) == false 
       puts "checkmate!"
      return true
    
    else  
      return false
    end

  end
  
  



end
  
