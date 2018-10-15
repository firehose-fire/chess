require 'rails_helper'

RSpec.describe Piece, type: :model do

  

  before(:all) do 
    user = FactoryBot.build(:user)
    game = FactoryBot.build(:game)
  end
  
    describe "move_to!(new_x, new_y)" do
    it "should give a runtime error can't capture your own piece" do
      located_piece = FactoryBot.create(:pawn,
                        coordinate_x: 3,
                        coordinate_y: 1,
                        piece_color: 'black', user_id: 1)
      piece = FactoryBot.create(:pawn,
                                coordinate_x: 2,
                                coordinate_y: 0,
                                piece_color: 'black', user_id: 1)
      expect{piece.move_to!(3,1)}.to raise_error(RuntimeError)
    end
       it "should move and update the position" do
      piece = FactoryBot.create(:pawn,
                                coordinate_x: 2,
                                coordinate_y: 1,
                                piece_color: 'black', user_id: 1)
      piece.move_to!(2,2)
      expect([piece.coordinate_x,piece.coordinate_y]).to eq([2,2])
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

end


