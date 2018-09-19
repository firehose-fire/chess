require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "is_obstructed?" do
    it "should return true if there is a piece obstructing the vertical path"
    user = FactoryBot.create(:user)
    game = FactoryBot.create(:game)
    piece1 = game.pieces.find_by(coordinate_x: 0 , coordinate_y: 0)
    piece2 = game.pieces.find_by(coordinate_x: 0 , coordinate_y: 3)
    
    expected(result).to eq (true)

  describe "move_to!(new_x, new_y)" do
    it "should give a runtime error can't capture your own piece" do
      located_piece = FactoryBot.create(:piece,
                        coordinate_x: 3,
                        coordinate_y: 1,
                        piece_color: 'black', user_id: 1)
      piece = FactoryBot.create(:piece,
                                coordinate_x: 3,
                                coordinate_y: 0,
                                piece_color: 'black', user_id: 1)
      expect{piece.move_to!(3,1)}.to raise_error(RuntimeError)

    end

    it "should set the captured piece to true" do
      located_piece = FactoryBot.create(:piece,
                                        coordinate_x: 3,
                                        coordinate_y: 1,
                                        piece_color: 'white', user_id: 2, captured: false)
      piece = FactoryBot.create(:piece,
                                coordinate_x: 3,
                                coordinate_y: 0,
                                piece_color: 'black', user_id: 1)

      expect(piece.move_to!(3,2)).to eq(located_piece.captured = true)

    end

    it "should move and update the position" do
      piece = FactoryBot.create(:piece,
                                coordinate_x: 3,
                                coordinate_y: 0,
                                piece_color: 'black', user_id: 1)
      piece.move_to!(6,3)
      expect([piece.coordinate_x,piece.coordinate_y]).to eq([6,3])

    end

  end
end
