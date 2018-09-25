require 'rails_helper'

RSpec.describe Pawn, type: :model do
  def build_game_and_user
    game = FactoryBot.build(:game, id: 4)
    user_white = FactoryBot.build(:user, id: 4)
    user_black = FactoryBot.build(:user, id: 5)
  end

  describe 'move_one_space?' do
    it 'return true if the pawn can move one space' do
      pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
      expect(pawn.move_one_space?(0, 5)).to eq(true)
    end

    it 'return false if the pawn moves more than one space' do
      pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
      expect(pawn.move_one_space?(0, 4)).to eq(false)
    end
  end

  describe 'move_two_spaces?' do
    it 'return true if the pawn moves 2 spaces' do
      pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 1)
      expect(pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if the pawn moves 3 spaces' do
      pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 1)
      expect(pawn.move_two_spaces?(0, 4)).to eq(false)
    end

    it 'return false if the pawn moves 2 spaces after a first move' do
      pawn = FactoryBot.create(:pawn, coordinate_x: 5, coordinate_y: 1)
      pawn.update_attributes(coordinate_y: 2)
      expect(pawn.move_two_spaces?(5, 3)).to eq(false)
    end
  end

  describe 'capture_diagonal?' do
    it 'return true if can capture a diagonal' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 6, coordinate_y: 1, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 7, coordinate_y: 6, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 2)
      expect(pawn_white.capture_diagonal?(7, 2)).to eq(true)
    end

    it 'return false if can capture a diagonal' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 5, coordinate_y: 1, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 4, coordinate_y: 6, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 2)
      expect(pawn_white.capture_diagonal?(4, 2)).to eq(true)
    end

    it 'return false if can capture a diagonal' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 4, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 3, coordinate_y: 1, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 5)
      expect(pawn_white.capture_diagonal?(3, 5)).to eq(true)
    end

    it 'return false if can capture a diagonal' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 4, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 5, coordinate_y: 1, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 5)
      expect(pawn_white.capture_diagonal?(5, 5)).to eq(true)
    end
  end

  describe 'pawn_valid_move?' do
    it 'return true for 2 space move with no obstruction' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 5, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 5, coordinate_y: 1, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 3)
      expect(pawn_black.pawn_valid_move?(5, 5)).to eq(true)
    end

    it 'return true for 1 space move with no obstruction' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 5, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 5, coordinate_y: 1, user_id: 5)
      pawn_black.update_attributes(coordinate_y: 3)
      expect(pawn_black.pawn_valid_move?(5, 4)).to eq(true)
    end

    it 'return false for 2 space move with obstruction' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 2, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 2, coordinate_y: 1, user_id: 5)
      pawn_white.update_attributes(coordinate_y: 5)
      expect(pawn_black.pawn_valid_move?(5, 6)).to eq(false)
    end

    it 'return false for 1 space move with obstruction' do
      pawn_white = FactoryBot.build(:pawn, piece_color: 'white', coordinate_x: 2, coordinate_y: 6, user_id: 4)
      pawn_black = FactoryBot.build(:pawn, piece_color: 'black', coordinate_x: 2, coordinate_y: 1, user_id: 5)
      pawn_white.update_attributes(coordinate_y: 5)
      expect(pawn_black.pawn_valid_move?(5, 6)).to eq(false)
    end
  end
end