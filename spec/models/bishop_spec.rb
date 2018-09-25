require 'rails_helper'

RSpec.describe Bishop, type: :model do
   before(:all) do 
    game = FactoryBot.build(:game)
    user = FactoryBot.build(:user)
    @bishop = FactoryBot.build(:bishop, coordinate_x: 3, coordinate_y: 3, game_id: game.id, user_id: user.id)      
  end
   describe "valid_move?" do
    
    it "should return true if the rook piece move is valid (diagonal up right)" do
      expect(@bishop.valid_move?(5,5)).to eq(true)
    end

     it "should return true if the rook piece move is valid (diagonal up left)" do
      expect(@bishop.valid_move?(2,4)).to eq(true)
    end

    it "should return true if the rook piece move is valid (diagonal down right)" do
      expect(@bishop.valid_move?(4,2)).to eq(true)
    end

     it "should return true if the rook piece move is valid (diagonal down left)" do
      expect(@bishop.valid_move?(2,2)).to eq(true)
    end
     
    it "should return false if the rook piece move is not valid" do
      expect(@bishop.valid_move?(2,3)).to eq(false)
      expect(@bishop.valid_move?(4,5)).to eq(false)
      expect(@bishop.valid_move?(8,0)).to eq(false)
    end

    it "should return false if rook move is valid but obstructed" do
      obstructing_piece = FactoryBot.create(:piece, coordinate_x: 2, coordinate_y: 4)
      expect(@bishop.valid_move?(1,5)).to eq(false)
      obstructing_piece2 = FactoryBot.create(:piece, coordinate_x: 4, coordinate_y: 4)
      expect(@bishop.valid_move?(5,5)).to eq(false)

    end
     
   end
end
