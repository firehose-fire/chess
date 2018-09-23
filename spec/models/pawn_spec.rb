require 'rails_helper'

RSpec.describe Pawn, type: :model do
  before(:all) do
    game = FactoryBot.build(:game, id: 4)
    user = FactoryBot.build(:user, id: 4)
    @pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
    @pawn1 = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 1)
    @pawn2 = FactoryBot.create(:pawn, coordinate_x: 5, coordinate_y: 1)
    @pawn2.update_attributes(coordinate_y: 2)
    @pawn3 = FactoryBot.build(:pawn, coordinate_x: 6, coordinate_y: 1)
    @pawn4 = FactoryBot.build(:pawn, coordinate_x: 7, coordinate_y: 6)
    @pawn4.update_attributes(coordinate_y: 2)
  end


  describe 'move_one_space?' do
    it 'return true if the pawn can move one space' do
      expect(@pawn.move_one_space?(0, 5)).to eq(true)
    end

    it 'return false if the pawn moves more than one space' do
      expect(@pawn.move_one_space?(0, 4)).to eq(false)
    end
  end

  describe 'move_two_spaces?' do
    it 'return true if the pawn moves 2 spaces' do
      expect(@pawn1.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if the pawn moves 3 spaces' do
      expect(@pawn1.move_two_spaces?(0, 4)).to eq(false)
    end

    it 'return false if the pawn moves 2 spaces after a first move' do
      expect(@pawn2.move_two_spaces?(5, 3)).to eq(false)
    end
  end

  describe 'capture_diagonal?' do
    it 'return true if can capture a diagonal' do
      expect(@pawn3.capture_diagonal?(6, 2)).to eq(true)
    end
  end
end