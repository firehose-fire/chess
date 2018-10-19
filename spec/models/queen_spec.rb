require 'rails_helper'

RSpec.describe Queen, type: :model do

  game = FactoryBot.build(:game)
  user = FactoryBot.build(:user)

  queen = FactoryBot.create(:queen, game_id: 1, user_id: 4, coordinate_x: 3, coordinate_y: 0)
  piece = FactoryBot.create(:piece, game_id: 1, user_id: 5, coordinate_x: 6, coordinate_y: 0)

  describe "valid queen move?" do
    it "should check the horizontal move and return true" do
      expect(queen.valid_move?(5,0)).to eq(true)
    end

    it "should check the vertical move and return true" do
      expect(queen.valid_move?(3,3)).to eq(true)
    end

    it "should check the diagonal move and return true" do
      expect(queen.valid_move?(4,1)).to eq(true)
    end

    it "should return false if there's an obstruction between the move" do
      expect(queen.valid_move?(7,0)).to eq(false)
    end
  end
end
