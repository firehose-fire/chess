
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
  
  def populate_the_game 

    # Pawn creation for white and black player
    (0..7).each do |b|
      Pawn.create(coordinate_x: b, coordinate_y: 1, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    end

    (0..7).each do |w|
      Pawn.create(coordinate_x: w, coordinate_y: 6, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    end

    # King creation for white and black player
    King.create(coordinate_x: 4, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    King.create(coordinate_x: 4, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

    # Bishop creation for white and black player
    Bishop.create(coordinate_x: 2, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Bishop.create(coordinate_x: 5, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Bishop.create(coordinate_x: 2, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    Bishop.create(coordinate_x: 5, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

    # Rook creation for white and black player
    Rook.create(coordinate_x: 0, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Rook.create(coordinate_x: 7, coordinate_y: 0, piece_color: 'black', user_id: self.user_black_id, game_id: self.id)
    Rook.create(coordinate_x: 0, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)
    Rook.create(coordinate_x: 7, coordinate_y: 7, piece_color: 'white', user_id: self.user_white_id, game_id: self.id)

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
        # puts "#{piece.inspect}"   
          return true if is_valid_move_capture?(piece) == true
        end
      return false
    end

    if user == user_white
      @king = pieces.where(type: "King", user_id: user_white).first
      @king_x = @king.coordinate_x
      @king_y = @king.coordinate_y   
        user_black.pieces.where(game: self.id).each do |piece|
          return true if is_valid_move_capture?(piece) == true
        end   
      return false
    end
  end


  def is_valid_move_capture?(piece)   
    puts "____#{piece.inspect}"
    puts "                     "
     if piece.type != "King"
          #checks if the move is valid
              puts "trying to check move #{piece.inspect} to #{@king_x}, #{@king_y}"
              puts "=====#{piece.valid_move?(@king_x,@king_y)}"
               puts "                     "
             if piece.valid_move?(@king_x,@king_y) == true && piece.is_capture_valid?(@king_x,@king_y) == true 
                   puts "--<#{piece.inspect} is valid move and capture valid"
              @check_piece = piece
               # puts "Check piece____#{@check_piece.inspect}"
              return true
            # end
          end  
          return false
        end
  end

  
  def checkmate?(user)
    puts "#{user.inspect}"
    @user = user
    if is_check?(@user) == true
    
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
         #is move in bounds?
        if king.boundaries(move[0], move[1]) == true
          #if space is empty and check piece cannot
         if pieces.where(coordinate_x: move[0], coordinate_y: move[1]).first == nil 
              if @check_piece.valid_move?(move[0],move[1]) == false
            puts "The check piece #{@check_piece.type} can move where i want to go? #{@check_piece.valid_move?(move[0],move[1])}"
            
            # if @check_piece.valid_move?(move[0],move[1]) == false
              puts "I can move my king to #{move[0]} #{move[1]}"
              return false 
            end

          end

        end

      end
      puts "><><#{@check_piece.inspect}"
      puts "checkmate!"
      return true
    
    else  
      return false
   end

  end
  
  
  
end
  
