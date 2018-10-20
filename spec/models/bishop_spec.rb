require 'rails_helper'

RSpec.describe Bishop, type: :model do
   before(:each) do 
    @game = FactoryBot.build(:game)
    @user = FactoryBot.build(:user)
    @bishop = FactoryBot.build(:bishop, coordinate_x: 4, coordinate_y: 4, game: @game, user: @user) 
     
  end
   describe "valid_move?" do
    
    it "should return true if the bishop piece move is valid (diagonal up right)" do
      expect(@bishop.valid_move?(5,5)).to eq(true)
    end

     it "should return true if the bishop piece move is valid (diagonal up left)" do
      expect(@bishop.valid_move?(3,5)).to eq(true)
    end

    it "should return true if the bishop piece move is valid (diagonal down right)" do
      expect(@bishop.valid_move?(5,3)).to eq(true)
    end

     it "should return true if the bishop piece move is valid (diagonal down left)" do
      # @bishop.move_to!(5,3)
      expect(@bishop.valid_move?(3,3)).to eq(true)
    end
     
    it "should return true if the bishop piece move is valid (diagonal down right)" do
      @bishop.move_to!(5,3)
      expect(@bishop.valid_move?(6,2)).to eq(true)
    end
    it "should return false if the bishop piece move is not valid" do
      expect(@bishop.valid_move?(2,3)).to eq(false)
      expect(@bishop.valid_move?(4,5)).to eq(false)
      expect(@bishop.valid_move?(7,0)).to eq(false)
    end

    it "should return false if bishop move is valid but obstructed" do
      obstructing_piece = FactoryBot.create(:piece, user_id: 1, game_id: @game.id, coordinate_x: 3, coordinate_y:5)
      expect(@bishop.valid_move?(2,6)).to eq(false)
      obstructing_piece2 = FactoryBot.create(:piece, user_id: 1, game_id: @game.id, coordinate_x: 5, coordinate_y: 5)
      expect(@bishop.valid_move?(6,6)).to eq(false)

    end
     
   end
end
