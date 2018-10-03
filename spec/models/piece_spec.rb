require 'rails_helper'

RSpec.describe Piece, type: :model do

  

  before(:all) do 
    user = FactoryBot.build(:user)
    game = FactoryBot.build(:game)
  end
  
    describe "move_to!(new_x, new_y)" do
    it "should give a runtime error can't capture your own piece" do
      located_piece = FactoryBot.create(:piece,
                        coordinate_x: 3,
                        coordinate_y: 1,
                        piece_color: 'black', user_id: 1)
      piece = FactoryBot.create(:piece,
                                coordinate_x: 3,
                                coordinate_y: 0,
                                piece_color: 'black', user_id: 1)
      expect{piece.move_to!(3,1)}.to raise_error(RuntimeError)
    end
       it "should move and update the position" do
      piece = FactoryBot.create(:piece,
                                coordinate_x: 3,
                                coordinate_y: 0,
                                piece_color: 'black', 
                                user_id: 1,
                                move: false)
      piece.move_to!(6,3)
      expect([piece.coordinate_x,piece.coordinate_y]).to eq([6,3])
      expect(piece.move).to eq(true)
    end
  end
  

  # 
  describe "is_obstructed?" do

    #VERTICAL
    it "should return true if there is a piece obstructing the vertical path bottom to top" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 0 )   
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 3)  
      expect(piece.is_obstructed?(0, 5)).to eq(true)
    end

    it "should return true if there is a piece obstructing the vertical path top to bottom" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 5 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 3)  
      expect(piece.is_obstructed?(0,0)).to eq(true)
    end

    it "should return false if there is NOT piece obstructing the vertical path top to bottom" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 5 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 0)
      expect(piece.is_obstructed?(0,3)).to eq(false)
    end

    #HORIZONTAL

    it "should return true if there is a piece obstructing  the horizontal path left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 0)
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 0)
      expect(piece.is_obstructed?(5, 0)).to eq(true)
    end


    it "should return true if there is a piece obstructing of the horizontal path right to left" do
      piece = FactoryBot.create(:piece, coordinate_x: 5, coordinate_y: 0)
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 0)
      expect(piece.is_obstructed?(2, 0)).to eq(true)
    end

    it "should return false if there is NOT piece obstructing the horizontal left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 0 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 3)
      expect(piece.is_obstructed?(5,0)).to eq(false)
    end

     it "should return false if there is NOT piece obstructing the horizontal left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 3 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 2)
      expect(piece.is_obstructed?(5,3)).to eq(false)
    end

    #DIAGANOL
    it "should return true if there is a piece obstructing the diagonal path top to bottom and left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 5)
      expect(piece.is_obstructed?(7,0)).to eq(true)
    end

    it "should return true if there is a piece obstructing the diagonal path top to bottom and right to left" do
      piece = FactoryBot.create(:piece, coordinate_x: 7, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 1, coordinate_y: 1)
      expect(piece.is_obstructed?(0,0)).to eq(true)
    end


    it "should return true if there is a piece obstructing the diaganol path bottom to top and right to left" do
      piece = FactoryBot.create(:piece, coordinate_x: 7, coordinate_y: 0 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 5, coordinate_y: 2)
      expect(piece.is_obstructed?(0,7)).to eq(true)
    end

    it "should return true if there is a piece obstructing the diaganol path bottom to top and left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 0 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 6, coordinate_y: 6)
      expect(piece.is_obstructed?(7,7)).to eq(true)
    end


    #Invalid raises Error 
    # it "raises" do
    #   piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 7 )
    #   piece_obstruction = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 5)
    #   expect { piece.is_obstructed?(8,8) }.to raise_error
    # end
    
  end

  describe "can castle" do
    it "should return true if the King has NOT moved" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)

     expect(white_king.can_castle?(7,7)).to eq true
    end

    it "should return false if the King HAS moved" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)
     white_king.move_to!(4,4)

     expect(white_king.can_castle?(7,7)).to eq false
    end

    it "should return true if the White Rook Kingside has NOT moved and no obstruction" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)
     white_rook_kingside = FactoryBot.create(:rook, coordinate_x: 0, coordinate_y: 7, piece_color: 'white', move: false)

     expect(white_king.can_castle?(0,7)).to eq true
    end

    it "should return false if the White Rook Kingside has NOT moved and there is an obstruction" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)
     white_rook_kingside = FactoryBot.create(:rook, coordinate_x: 0, coordinate_y: 7, piece_color: 'white', move: false)
     piece_obstruction = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 7)
     
     expect(white_king.can_castle?(0,7)).to eq false
    end

    it "should return false if the White Rook Kingside HAS moved" do
     white_rook_kingside = FactoryBot.create(:rook, coordinate_x: 0, coordinate_y: 7, piece_color: 'white', move: false)

     white_rook_kingside.move_to!(1,7)

     expect(white_rook_kingside.can_castle?(0,7)).to eq false
    end

    it "should return true if the White Rook Queenside has NOT moved" do
     white_rook_queenside = FactoryBot.create(:rook, coordinate_x: 7, coordinate_y: 7, piece_color: 'white', move: false)

     expect(white_rook_queenside.can_castle?(7,7)).to eq true
    end

    it "should return false if the White Rook Queenside has NOT moved but there is an obstruction" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)
     white_rook_queenside = FactoryBot.create(:rook, coordinate_x: 7, coordinate_y: 7, piece_color: 'white', move: false)
     piece_obstruction = FactoryBot.create(:piece, coordinate_x: 6, coordinate_y: 7)

     expect(white_rook_queenside.can_castle?(7,7)).to eq false
    end

    it "should return false if the White Rook Queenside HAS moved" do
     white_rook_queenside = FactoryBot.create(:rook, coordinate_x: 7, coordinate_y: 7, piece_color: 'white', move: false)

     white_rook_queenside.move_to!(7,6)

     expect(white_rook_queenside.can_castle?(7,7)).to eq false
    end

    it "should return true if castling move is NOT obstructed" do
     white_king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 7, piece_color: 'white', move: false)
     white_rook_queenside = FactoryBot.create(:rook, coordinate_x: 7, coordinate_y: 7, piece_color: 'white', move: false)

     expect(white_rook_queenside.can_castle?(7,7)).to eq true
    end

  end

  



end


