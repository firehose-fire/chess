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

  # describe "is check for the king" do


  #   it "should see if the color black king is in a check position and return true" do
  #     user_black = FactoryBot.create(:user)
  #     user_white = FactoryBot.create(:user)

  #     game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, )
  #     king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 3, piece_color: 'black', user_id: user_black.id, game_id: game.id)
  #     piece = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 4, piece_color: 'white',  user_id: user_white.id, game_id: game.id)

  #     # piece.move_to!(4,3)

  #     expect(game.is_check?(game.user_black)).to eq true


  #   end

  #   it "should see if the color white king is in a check position and return true" do
  #     user_black = FactoryBot.build(:user)
  #     user_white = FactoryBot.build(:user)

  #     game = FactoryBot.build(:game, user_white_id: user_white.id, user_black_id: user_black.id)
  #     king = FactoryBot.build(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'black', user_id: user_black.id, game_id: game.id)
  #     piece = FactoryBot.build(:pawn, coordinate_x: 3, coordinate_y: 6, piece_color: 'white',  user_id: user_white.id, game_id: game.id)

  #     # piece.move_to!(4,7)

  #     expect(game.is_check?(game.user_white)).to eq true


  #   end
  # end

  describe "game is in state of checkmate" do
    before(:each) do 
      # pawn0 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 0, coordinate_y: 1).first
      # pawn1 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 1, coordinate_y: 1).first
      # pawn2 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 2, coordinate_y: 1).first
      # pawn3 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 3, coordinate_y: 1).first
      # pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first
      # pawn5 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 5, coordinate_y: 1).first
      # pawn6 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 6, coordinate_y: 1).first
      # pawn7 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 7, coordinate_y: 1).first
      # king = game.pieces.where(user_id: user_black.id, type: 'King').first
      # queen = game.pieces.where(user_id: user_black.id, type: 'Queen').first
      # bishop = game.pieces.where(user_id: user_black.id, type: 'Bishop').first
      # knight = game.pieces.where(user_id: user_black.id, type: 'Knight').first
      # knight2 = game.pieces.where(user_id: user_black.id, type: 'Knight', id: !knight.id)
      # rook = game.pieces.where(user_id: user_black.id, type: 'Rook').first
      # rook2 = game.pieces.where(user_id: user_black.id, type: 'Rook')
      
    end


    it "should verify if king is in check and can make a move to get out of check and return false" do
    
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, id: 99 )
 
      knight = FactoryBot.create(:knight, coordinate_x: 5, coordinate_y: 2, piece_color: 'white',  user_id: user_white.id, game_id: game.id)
      
      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first

    
      pawn4.move_to!(4, 2)      

      expect(game.checkmate?(game.user_black)).to eq false
    end

    it "should verify if king is in check and cannot make a move to get out of check and return true" do
    
      user_black = FactoryBot.build(:user)
      user_white = FactoryBot.build(:user)
      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, id: 99 )
 
      knight = FactoryBot.create(:knight, coordinate_x: 5, coordinate_y: 2, piece_color: 'white',  user_id: user_white.id, game_id: game.id)
      
      pawn4 = game.pieces.where(user_id: user_black.id, type: 'Pawn', coordinate_x: 4, coordinate_y: 1).first

    
      # pawn4.move_to!(4, 2)      

      expect(game.checkmate?(game.user_black)).to eq true
    end

    # it "should verify if king is in check and another piece cannot block checkmate" do

    # end

    # it "should verify if king is in check and another piece cannot capture opponents checking piece" do
    

    # end


  end


end
