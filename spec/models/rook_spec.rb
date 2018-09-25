require 'rails_helper'

RSpec.describe Rook, type: :model do  

  before(:all) do 
    game = FactoryBot.build(:game)
    user = FactoryBot.build(:user)
    @rook = FactoryBot.build(:rook, coordinate_x: 1, coordinate_y: 3, game_id: game.id, user_id: user.id)      
  end

  describe "rook valid_move?" do
    
    it "should return true if the rook piece move is valid (vertical)" do
      expect(@rook.valid_move?(1,5)).to eq(true)
    end

    it "should return true if the rook piece move is valid (horizontal)" do
      expect(@rook.valid_move?(7,3)).to eq(true)
    end

    
    it "should return false if the rook piece move is not valid " do
      expect(@rook.valid_move?(0,4)).to eq(false)
      expect(@rook.valid_move?(2,2)).to eq(false)
    end

    it "should return false if move is valid vertical but obstructed" do
      obstructing_piece = FactoryBot.build(:piece, coordinate_x: 2, coordinate_y: 5)
      expect(@rook.valid_move?(2,7)).to eq(false)
    end

    

  end
  
end
