
class Game < ApplicationRecord
  belongs_to :user_white, class_name: 'User', optional: true
  belongs_to :user_black, class_name: 'User', optional: true

  has_many :pieces

  after_create :populate_the_game
  
  scope :available, -> { where(user_white_id: nil) }

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
      king = pieces.where(type: "King", user_id: user_black).first
      king_x = king.coordinate_x
      king_y = king.coordinate_y
      user_white.pieces.where(game: self.id).each do |piece|
        if piece.type != "King"
          return true if piece.is_capture_valid?(king_x,king_y) && piece.is_occupied?(king_x,king_y)
        end
        return false
      end
    end

    if user == user_white
    king = pieces.where(type: "King", user_id: user_white).first
    king_x = king.coordinate_x
    king_y = king.coordinate_y
    user_white.pieces.where(game: self.id).each do |piece|
      if piece.type != "King"
        return true if piece.is_capture_valid?(king_x,king_y) && piece.is_occupied?(king_x,king_y)
      end
      return false
      end
    end
  end
  
  



end
  
