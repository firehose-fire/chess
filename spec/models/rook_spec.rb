require 'rails_helper'

RSpec.describe Rook, type: :model do
  
  before(:all) do 
    game = FactoryBot.build(:game)
    user = FactoryBot.build(:user)
    @rook = FactoryBot.build(:rook, coordinate_x: 0, coordinate_y: 3, game_id: game.id, user_id: user.id)      
  end

  describe "rook valid_move?" do
    
    it "should return true if the rook piece move is valid (vertical)" do
      expect(@rook.valid_move?(0,7)).to eq(true)
    end

    it "should return true if the rook piece move is valid (horizontal)" do
      expect(@rook.valid_move?(7,3)).to eq(true)
    end

    
    it "should return false if the rook piece move is not valid (horizontal or vertical)" do
      expect(@rook.valid_move?(1,1)).to eq(false)
      expect(@rook.valid_move?(0,8)).to eq(false)
      expect(@rook.valid_move?(8,0)).to eq(false)
    end

    

  end

end
