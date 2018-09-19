require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed?" do
    it "should return true if there is a piece obstructing the vertical path"
    user = FactoryBot.create(:user)
    game = FactoryBot.create(:game)
    piece1 = game.pieces.find_by(coordinate_x: 0 , coordinate_y: 0)
    piece2 = game.pieces.find_by(coordinate_x: 0 , coordinate_y: 3)
    
    expected(result).to eq (true)
  end
end
