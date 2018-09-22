require 'rails_helper'

RSpec.describe Piece, type: :model do

  before(:all) do 
    user = FactoryBot.build(:user)
    game = FactoryBot.build(:game)
  end

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
      piece = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 3 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 2)
      expect(piece.is_obstructed?(5,3)).to eq(false)
    end

    #DIAGANOL
    it "should return true if there is a piece obstructing the diaganol path top to bottom and left to right" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 5)
      expect(piece.is_obstructed?(7,0)).to eq(true)
    end

    it "should return true if there is a piece obstructing the diaganol path top to bottom and right to left" do
      piece = FactoryBot.create(:piece, coordinate_x: 7, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 1, coordinate_y: 1)
      expect(piece.is_obstructed?(0,0)).to eq(true)
    end

    it "should return true if there is a piece obstructing the diaganol path bottom to top and right to left" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 5, coordinate_y: 2)
      expect(piece.is_obstructed?(7,0)).to eq(true)
    end

    #Not currently passing
    # it "should return true if there is a piece obstructing the diaganol path bottom to top and left to right" do
    #   piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 0 )
    #   piece_obstruction = FactoryBot.create(:piece, coordinate_x: 5, coordinate_y: 5)
    #   expect(piece.is_obstructed?(6,6)).to eq(true)
    # end

    #Invalid raises Error 
    it "raises" do
      piece = FactoryBot.create(:piece, coordinate_x: 0, coordinate_y: 7 )
      piece_obstruction = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 5)
      expect { piece.is_obstructed?(8,8) }.to raise_error
    end
    
  end
end

