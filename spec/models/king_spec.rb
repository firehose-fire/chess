require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move" do
    it "should check if the king piece move is valid" do
      king = FactoryBot.create(:piece, type: 'king', coordinate_x: 3, coordinate_y: 0)
    end
  end
end
