require 'rails_helper'

RSpec.describe Bishop, type: :model do
   before(:all) do 
    game = FactoryBot.build(:game)
    user = FactoryBot.build(:user)
    @bishop = FactoryBot.build(:bishop, coordinate_x: 2, coordinate_y: 2, game_id: game.id, user_id: user.id)      
  end
   describe "bishop valid_move?" do
    
    it "should return true if the rook piece move is valid (diagonal up left)" do
      expect(@bishop.valid_move?(3,3)).to eq(true)
    end
    
     it "should return true if the rook piece move is valid (diagonal up right)" do
      expect(@bishop.valid_move?(1,3)).to eq(true)
    end
     
    # it "should return false if the rook piece move is not valid (horizontal or vertical)" do
    #   expect(@bishop.valid_move?(1,1)).to eq(false)
    #   expect(@bishop.valid_move?(0,8)).to eq(false)
    #   expect(@bishop.valid_move?(8,0)).to eq(false)
    # end
     
   end
end
