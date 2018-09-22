require 'rails_helper'

RSpec.describe Queen, type: :model do

  queen = FactoryBot.create(:queen, coordinate_x: 3, coordinate_y: 0)
  piece = FactoryBot.create(:piece, coordinate_x: 6, coordinate_y: 0)

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

    it "should return true if there's an obstruction between the move" do
      expect(queen.valid_move?(7,0)).to eq(true)
    end
  end
end
