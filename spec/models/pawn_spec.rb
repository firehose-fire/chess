require 'rails_helper'

RSpec.describe Pawn, type: :model do
  def build_game_and_user
    game = FactoryBot.build(:game, id: 4)
    user_white = FactoryBot.build(:user, id: 4)
    user_black = FactoryBot.build(:user, id: 5)
  end

  def create_black_pawn(x:, y:, user_id:)
    pawn_black = FactoryBot.create(:pawn, piece_color: 'black', coordinate_x: 5, coordinate_y: 1, user_id: user_id)
    pawn_black.update_attributes(coordinate_y: y)
    pawn_black.update_attributes(coordinate_x: x)
    pawn_black
  end

  def create_white_pawn(x:, y:, user_id:)
    pawn_white = FactoryBot.create(:pawn, piece_color: 'white', coordinate_x: 6, coordinate_y: 6, user_id: user_id)
    pawn_white.update_attributes(coordinate_y: y)
    pawn_white.update_attributes(coordinate_x: x)
    pawn_white
  end

  describe 'move_one_space?' do
    it 'return true if the pawn can move one space white pawn' do
      white_pawn = create_white_pawn(x: 0, y: 6, user_id: 4)
      expect(white_pawn.move_one_space?(0, 5)).to eq(true) #undo
    end

    it 'return true if the pawn can move one space black pawn' do
      black_pawn = create_black_pawn(x: 0, y: 1, user_id: 4)
      expect(black_pawn.move_one_space?(0, 2)).to eq(true)
    end

    it 'return false if the pawn moves more than one space' do
      pawn = FactoryBot.build(:pawn, coordinate_x: 0, coordinate_y: 6)
      expect(pawn.move_one_space?(0, 4)).to eq(false)
    end
  end

  describe 'move_two_spaces?' do
    it 'return true if the pawn moves 2 spaces' do
      black_pawn = create_black_pawn(x: 0, y: 1, user_id: 5)
      expect(black_pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return true if the pawn moves 2 spaces' do
      white_pawn = create_white_pawn(x: 0, y: 5, user_id: 5)
      expect(white_pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if the pawn moves more than 2 spaces' do
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
      white_pawn = create_white_pawn(x: 6, y: 6, user_id: 4)
      black_pawn = create_black_pawn(x: 5, y: 5, user_id: 5)
      expect(white_pawn.capture_diagonal?(5, 5)).to eq(true)
    end

    it 'return false if can capture a diagonal' do
      white_pawn = create_white_pawn(x: 6, y: 6, user_id: 4)
      black_pawn = create_black_pawn(x: 7, y: 5, user_id: 5)
      expect(white_pawn.capture_diagonal?(7, 5)).to eq(true)
    end

    it 'return true if can capture diagonally to the right' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4)
      black_pawn = create_black_pawn(x: 3, y: 3, user_id: 5)
      expect(black_pawn.capture_diagonal?(4, 4)).to eq(true)
    end

    it 'return true if can capture a diagonal' do # to the left
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4)
      black_pawn = create_black_pawn(x: 5, y: 3, user_id: 5)
      expect(black_pawn.capture_diagonal?(4, 4)).to eq(true)
    end
  end 

  describe 'pawn_valid_move?' do
    it 'return true for 2 space move with no obstruction from starting point' do
      pawn_black = create_black_pawn(x: 5, y: 1, user_id: 4)
      expect(pawn_black.pawn_valid_move?(5, 3)).to eq(true)
    end

    it 'return true for 2 space move with no obstruction from starting point' do
      pawn_black = create_black_pawn(x: 5, y: 1, user_id: 4)
      expect(pawn_black.pawn_valid_move?(5, 3)).to eq(true)
    end

    it 'return true for 1 space move with no obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4)
      expect(white_pawn.pawn_valid_move?(4, 3)).to eq(true)
    end

    it 'return false for 2 space move with obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4)
      black_pawn = create_black_pawn(x: 4, y: 3, user_id: 5)
      expect(white_pawn.pawn_valid_move?(4, 2)).to eq(false)
    end

    it 'return false for 1 space move with obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4)
      black_pawn = create_black_pawn(x: 4, y: 3, user_id: 5)
      expect(white_pawn.pawn_valid_move?(4, 3)).to eq(false)
    end
  end
end