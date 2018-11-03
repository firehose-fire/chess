require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'populate_game' do
    user1 = FactoryBot.build(:user)
    user2 = FactoryBot.build(:user)

    game = FactoryBot.build(:game, user_white_id: user1.id, user_black_id: user2.id)
    game.populate_the_game
    expect(game.populate_the_game).to be_valid

    # Pawn test for black and white pieces
    expect(game.piece_at(0, 1)).to have_attributes(type: 'Pawn', piece_color: 'black')
    expect(game.piece_at(0, 6)).to have_attributes(type: 'Pawn', piece_color: 'white')

    # King test for black and white pieces
    expect(game.piece_at(4, 0)).to have_attributes(type: 'King', piece_color: 'black')
    expect(game.piece_at(4, 7)).to have_attributes(type: 'King', piece_color: 'white')

    # Bishop test for black and white pieces
    expect(game.piece_at(2, 0)).to have_attributes(type: 'Bishop', piece_color: 'black')
    expect(game.piece_at(2, 7)).to have_attributes(type: 'Bishop', piece_color: 'white')

    # Rook test for black and white pieces
    expect(game.piece_at(0, 0)).to have_attributes(type: 'Rook', piece_color: 'black')
    expect(game.piece_at(0, 7)).to have_attributes(type: 'Rook', piece_color: 'white')

    # Knight test for black and white pieces
    expect(game.piece_at(1, 0)).to have_attributes(type: 'Knight', piece_color: 'black')
    expect(game.piece_at(1, 7)).to have_attributes(type: 'Knight', piece_color: 'white')

    # Queen test for black and white pieces
    expect(game.piece_at(3, 0)).to have_attributes(type: 'Queen', piece_color: 'black')
    expect(game.piece_at(3, 7)).to have_attributes(type: 'Queen', piece_color: 'white')

  end

  describe "is check for the king" do

    it "should see if the color black king is in a check position and return true" do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)

      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id )
      king = game.pieces.where(user_id: user_black.id, type: 'King').first

      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      pawnWhite2 = game.pieces.where(user_id: user_white.id, type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first
      pawnWhite = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 2, piece_color: 'white',  user_id: user_white.id, game_id: game.id)

      pawn4.move_to!(4, 2)      
      pawnWhite2.move_to!(0,5)
      king.move_to!(4, 1)
      pawnWhite.move_to!(1,4)

      expect(game.is_check?(game.user_black)).to eq true


    end

    it "should see if the color white king is in a check position and return true" do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)

      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id )
      king = game.pieces.where(user_id: user_white.id, type: 'King').first
      pawn4 = game.pieces.where(user_id: user_white.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 6).first
      pawnBlack2 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 0, coordinate_y: 1).first
    
      pawnBlack = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 5, piece_color: 'black',  user_id: user_black.id, game_id: game.id)

      pawnBlack2.move_to!(0,2)
      
      pawn4.move_to!(4, 5)      
      pawnBlack2.move_to!(0,3)
      
      king.move_to!(4, 6)
      pawnBlack.move_to!(6,4)

      expect(game.is_check?(game.user_white)).to eq true


    end
  end

  describe "game is in state of checkmate" do
    

    it "and should verify if king is in check and can make a move to get out of check and return false" do
    
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, id: 999 )
 
      pawnblock = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 2, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 

      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      king = game.pieces.where(user_id: user_black.id, type: 'King').first

      pawnWhite = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first  
      

      pawn4.move_to!(4, 2)
      pawnWhite.move_to!(0,5)   
      king.move_to!(4, 1) 
      bishopCheck = FactoryBot.create(:bishop, coordinate_x: 5, coordinate_y: 2, piece_color: 'white',  user_id: user_white.id, game_id: game.id) 
    

      expect(game.checkmate?(game.user_black)).to eq false

    end


    it "should verify if king is in check and another piece can capture opponents checking piece and return true" do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id)
      
      king = game.pieces.where(user_id: user_black.id, type: 'King').first
      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      pawn5 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 5, coordinate_y: 1).first

      pawnWhite = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first  
      

      bishopCheck = FactoryBot.create(:bishop, coordinate_x: 5, coordinate_y: 2, piece_color: 'white',  user_id: user_white.id, game_id: game.id) 

      pawn4.move_to!(4, 2)
      pawnWhite.move_to!(0,5)        
      king.move_to!(4, 1)

      expect(game.checkmate?(game.user_black)).to eq false
      expect(game.capture_check?(game.user_black, bishopCheck)).to eq true
    end

    it "should verify if king is in check and another piece cannot capture opponents checking piece and return true" do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id)
      
      king = game.pieces.where(user_id: user_black.id, type: 'King').first
      queen = game.pieces.where(user_id: user_black.id, type: 'Queen').first
      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      pawn5 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 5, coordinate_y: 1).first
      
      check_piece = FactoryBot.create(:bishop, coordinate_x: 7, coordinate_y: 4, piece_color: 'white', user_id: user_white.id, game_id: game.id) 
      pawnWhite = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first  
      pawnWhite2 = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 1, coordinate_y: 6).first  

      pawn4.move_to!(4, 2)
      pawnWhite.move_to!(0,5)        
      king.move_to!(4, 1)
      pawnWhite.move_to!(0,4)  
      queen.move_to!(4, 0)
      pawnBlock = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 0, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
      pawnblock2 = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 2, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
    
      #testing this part within the is check function will not work
      expect(game.capture_check?(game.user_black, check_piece)).to eq false
    end

    it "should verify if king is in check and another piece can block checkmate on a diagonal path and return false" do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id)

      king = game.pieces.where(user_id: user_black.id, type: 'King').first
      queen = game.pieces.where(user_id: user_black.id, type: 'Queen').first
      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      pawn5 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 5, coordinate_y: 1).first
      
      bishopW = FactoryBot.create(:bishop, coordinate_x: 7, coordinate_y: 4, piece_color: 'white', user_id: user_white.id, game_id: game.id) 
      pawnWhite = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first  
        

      pawn4.move_to!(4, 2)
      pawnWhite.move_to!(0,5)      
      king.move_to!(4, 1)
      pawnWhite.move_to!(0,4)  
      queen.move_to!(4, 0)
      pawnBlock = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 0, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
      pawnblock2 = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 2, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 

      rookBlock = FactoryBot.create(:rook, coordinate_x: 3, coordinate_y: 3, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
     
      expect(game.checkmate?(game.user_black)).to eq false
    end

   it "and should verify if king is in check and cannot make a move to get out of check, no piece can block or capture the check piece and return true (e.g. Checkmate)" do
    
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, id: 1000)
    
      

      king = game.pieces.where(user_id: user_black.id, piece_color: 'black',type: 'King').first
      queen = game.pieces.where(user_id: user_black.id, piece_color: 'black',type: 'Queen').first
      bishop = game.pieces.where(user_id: user_black.id, piece_color: 'black',type: 'Bishop', coordinate_x: 5, coordinate_y: 0).first
      pawn3 = game.pieces.where(user_id: user_black.id, piece_color: 'black',type: 'Pawn', coordinate_x: 3, coordinate_y: 1).first     
      pawn4 = game.pieces.where(user_id: user_black.id, piece_color: 'black', type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      pawn5 = game.pieces.where(user_id: user_black.id, piece_color: 'black', type: 'Pawn', coordinate_x: 5, coordinate_y: 1).first
      bishop = game.pieces.where(user_id: user_black.id, piece_color: 'black', type: 'Bishop', coordinate_x: 5, coordinate_y: 0).first

      pawnWhite = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 0, coordinate_y: 6).first  
      pawnWhite2 = game.pieces.where(user_id: user_white.id, piece_color: 'white',type: 'Pawn', coordinate_x: 1, coordinate_y: 6).first  
     
      pawn4.move_to!(4, 2) 
      pawnWhite.move_to!(0, 5)
      pawn4.move_to!(4, 3)
      pawnWhite2.move_to!(1, 5)
      pawn4.move_to!(4, 4) 
      pawnWhite.move_to!(0, 4)
      pawn4.move_to!(4, 5) 
      pawnWhite2.move_to!(1, 4)
      rookCheck = FactoryBot.create(:rook, coordinate_x: 4, coordinate_y: 4, piece_color: 'white',  user_id: user_white.id, game_id: game.id) 

      king.move_to!(4, 1)
      pawnWhite.move_to!(0, 3)
      queen.move_to!(4, 0)
      pawnBlock = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 0, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
      pawnblock2 = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 2, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 
      pawnBlock3 = FactoryBot.create(:pawn, coordinate_x: 5, coordinate_y: 2, piece_color: 'black',  user_id: user_black.id, game_id: game.id) 

      
      expect(game.checkmate?(game.user_black)).to eq true
    end

  end


end
