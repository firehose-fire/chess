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

      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, )
      king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 3, piece_color: 'black', user_id: user_black.id, game_id: game.id)
      piece = FactoryBot.create(:pawn, coordinate_x: 3, coordinate_y: 4, piece_color: 'white',  user_id: user_white.id, game_id: game.id)

      # piece.move_to!(4,3)

      expect(game.is_check?(game.user_black)).to eq true


    end

    it "should see if the color white king is in a check position and return true" do
      user_black = FactoryBot.build(:user)
      user_white = FactoryBot.build(:user)

      game = FactoryBot.build(:game, user_white_id: user_white.id, user_black_id: user_black.id)
      king = FactoryBot.build(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', user_id: user_black.id, game_id: game.id)
      piece = FactoryBot.build(:pawn, coordinate_x: 3, coordinate_y: 6, piece_color: 'black',  user_id: user_white.id, game_id: game.id)

      # piece.move_to!(4,7)

      expect(game.is_check?(game.user_white)).to eq true


    end
  end

  describe "game is in state of checkmate" do
    before(:all) do 
      
      
    end


    it "should verify if king is in check and cannot make a move to get out of check" do
     # # check_piece = FactoryBot.build(:rook, coordinate_x: 3, coordinate_y: 4, game_id: game.id, user_id: user_black.id, piece_color: 'black')
      # king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 3, piece_color: 'black', user_id: user_black.id, game_id: game.id)
      # piece = FactoryBot.build(:pawn, coordinate_x: 3, coordinate_y: 4, piece_color: 'white',  user_id: user_white.id, game_id: game.id)

      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)

      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id, id: 99 )
      king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 0, piece_color: 'black', user_id: user_black.id, game_id: game.id)
      rook = FactoryBot.create(:rook, coordinate_x: 4, coordinate_y: 5, piece_color: 'white',  user_id: user_white.id, game_id: game.id)
      # pawn = FactoryBot.create(:pawn, coordinate_x: 5, coordinate_y: 1, game_id: game.id, user_id: user_black.id, piece_color: 'black')      
      # bishop = FactoryBot.build(:bishop, coordinate_x: 2, coordinate_y: 0, game_id: game.id, user_id: user_black.id, piece_color: 'black')      
      # pawn = FactoryBot.build(:pawn, coordinate_x: 2, coordinate_y: 1, game_id: game.id, user_id: user_black.id, piece_color: 'black')      
      # pawn = FactoryBot.build(:pawn, coordinate_x: 4, coordinate_y: 1, game_id: game.id, user_id: user_white.id, piece_color: 'white')      
     


      # expect(game.is_check?(game.user_black)).to eq true
      expect(game.checkmate?(game.user_black)).to eq true
    end

    # it "should verify if king is in check and another piece cannot block checkmate" do

    # end

    # it "should verify if king is in check and another piece cannot capture opponents checking piece" do
    

    # end


  end


end
