require 'rails_helper'

RSpec.describe King, type: :model do
  before(:all) do 
    game = FactoryBot.build(:game, id: 1)
    user = FactoryBot.build(:user, id: 1)
    @king = FactoryBot.build(:king, coordinate_x: 3, coordinate_y: 0, game_id: game.id, user_id: 1)      

  end

  it "is invalid without an x coordinate" do
    king = FactoryBot.build(:king, coordinate_x: nil)

    expect(king).to_not be_valid
  end

  describe "valid_move?" do
    it "should return true if the king piece move is valid" do
    expect(@king.valid_move?(4,1)).to eq(true)
    end
    
    it "should return false if the king piece move is not valid" do
    expect(@king.valid_move?(5,1)).to eq(false)

    end
  end
end
