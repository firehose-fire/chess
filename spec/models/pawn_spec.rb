require 'rails_helper'

RSpec.describe Pawn, type: :model do
  
    
    
    @pawn3 = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 6, coordinate_y: 1)
    @pawn4 = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 7, coordinate_y: 6)
    @pawn4.update_attributes(coordinate_y: 2)
  

  def build_game_and_user
    game = FactoryBot.build(:game, id: 4)
    user = FactoryBot.build(:user, id: 4)
  end

  describe 'move_one_space?' do
    it 'return true if the pawn can move one space' do
      @pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
      expect(@pawn.move_one_space?(0, 5)).to eq(true)
    end

    it 'return false if the pawn moves more than one space' do
      @pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
      expect(@pawn.move_one_space?(0, 4)).to eq(false)
    end
  end

  describe 'move_two_spaces?' do
    it 'return true if the pawn moves 2 spaces' do
      @pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 1)
      expect(@pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if the pawn moves 3 spaces' do
      @pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 1)
      expect(@pawn.move_two_spaces?(0, 4)).to eq(false)
    end

    it 'return false if the pawn moves 2 spaces after a first move' do
      @pawn = FactoryBot.create(:pawn, coordinate_x: 5, coordinate_y: 1)
      @pawn.update_attributes(coordinate_y: 2)
      expect(@pawn.move_two_spaces?(5, 3)).to eq(false)
    end
  end

  describe 'capture_diagonal?' do
    it 'return true if can capture a diagonal' do
      pawn_white = 
      pawn_black = 
      expect(@pawn3.capture_diagonal?(7, 2)).to eq(true)
    end
  end
end