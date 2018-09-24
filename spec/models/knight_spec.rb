require 'rails_helper'

RSpec.describe Knight, type: :model do
   
   before(:all) do 
    game = FactoryBot.build(:game)
    user = FactoryBot.build(:user)
    @knight = FactoryBot.build(:knight, coordinate_x: 2, coordinate_y:2 , game_id: game.id, user_id: user.id)      
    end

  describe "knight valid_move?" do
    
    it "should return true if the knight piece move is valid (vertical)" do
      expect(@knight.valid_move?(4,3)).to eq(true)
      expect(@knight.valid_move?(3,4)).to eq(true)
      expect(@knight.valid_move?(1,0)).to eq(true)
      expect(@knight.valid_move?(0,1)).to eq(true)
    end

    it "should return false if the knight piece move is not valid (horizontal or vertical)" do
      
       expect(@knight.valid_move?(8,0)).to eq(false)
       expect(@knight.valid_move?(4,4)).to eq(false)
       expect(@knight.valid_move?(2,0)).to eq(false)
       expect(@knight.valid_move?(3,5)).to eq(false)
    end
    
  end

end
