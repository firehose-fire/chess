require 'rails_helper'

RSpec.describe Pawn, type: :model do

  game = FactoryBot.build(:game)
  user = FactoryBot.build(:user)

  def create_black_pawn(x:, y:, user_id:, game_id:)
    pawn_black = FactoryBot.create(:pawn, game_id: game_id, piece_color: 'black', coordinate_x: x, coordinate_y: y, user_id: user_id)
    pawn_black
  end

  def create_white_pawn(x:, y:, user_id:, game_id:)
    pawn_white = FactoryBot.create(:pawn, game_id: game_id, piece_color: 'white', coordinate_x: x, coordinate_y: y, user_id: user_id)
    pawn_white
  end

  describe 'move_one_space?' do
    it 'return true if the white pawn can move one space' do
      white_pawn = create_white_pawn(x: 6, y: 6, user_id: 4, game_id: 1)
      expect(white_pawn.move_one_space?(6, 5)).to eq(true)
    end

    it 'return true if the black pawn can move one space' do
      black_pawn = create_black_pawn(x: 1, y: 1, user_id: 4, game_id: 1)
      expect(black_pawn.move_one_space?(1, 2)).to eq(true)
    end

    it 'return false if the pawn moves more than one space' do
      white_pawn = create_white_pawn(x: 6, y: 1, user_id: 4, game_id: 1)
      expect(white_pawn.move_one_space?(6, 4)).to eq(false)
    end
  end

  describe 'move_two_spaces?' do
    it 'return true if the pawn moves 2 spaces' do
      black_pawn = create_black_pawn(x: 0, y: 1, user_id: 5, game_id: 1)
      expect(black_pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if already moved' do
      black_pawn = create_black_pawn(x: 0, y: 1, user_id: 5, game_id: 1)
      black_pawn.move_to!(0, 2)
      expect(black_pawn.valid_move?(0, 4)).to eq false
    end

    it 'return true if the pawn moves 2 spaces' do
      white_pawn = create_white_pawn(x: 0, y: 5, user_id: 5, game_id: 1)
      expect(white_pawn.move_two_spaces?(0, 3)).to eq(true)
    end

    it 'return false if the pawn moves more than 2 spaces' do
      black_pawn = create_black_pawn(x: 0, y: 1, user_id: 4, game_id: 1)
      expect(black_pawn.move_two_spaces?(0, 4)).to eq(false)
    end

    it 'return false if the pawn moves 2 spaces after a first move' do
      black_pawn = create_black_pawn(x: 5, y: 1, user_id: 4, game_id: 1)
      black_pawn.move_to!(5, 2) 
      expect(black_pawn.move_two_spaces?(5, 4)).to eq(false)
    end
  end

  describe 'capture_diagonal?' do
    it 'return true if can capture a diagonal' do
      white_pawn = create_white_pawn(x: 6, y: 6, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 5, y: 5, user_id: 5, game_id: 1)
      expect(white_pawn.move_to!(5, 5)).to eq(true)
    end

    it 'return false if can capture a diagonal' do
      white_pawn = create_white_pawn(x: 6, y: 6, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 7, y: 5, user_id: 5, game_id: 1)
      expect(white_pawn.move_to!(7, 5)).to eq(true)
    end

    it 'return true if can capture diagonally to the right' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 3, y: 3, user_id: 5, game_id: 1)
      expect(black_pawn.move_to!(4, 4)).to eq(true)
    end

    it 'return true if can capture a diagonal' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 5, y: 3, user_id: 5, game_id: 1)
      expect(black_pawn.move_to!(4, 4)).to eq(true)
    end
  end 

  describe 'valid_move?' do
    it 'return true for 2 space move with no obstruction from starting point' do
      pawn_black = create_black_pawn(x: 5, y: 1, user_id: 4, game_id: 1)
      expect(pawn_black.move_to!(5, 3)).to eq(true)
    end

    it 'return true for 2 space move with no obstruction from starting point' do
      pawn_black = create_black_pawn(x: 5, y: 1, user_id: 4, game_id: 1)
      expect(pawn_black.move_to!(5, 3)).to eq(true)
    end

    it 'return true for 1 space move with no obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4, game_id: 1)
      expect(white_pawn.move_to!(4, 3)).to eq(true)
    end

    it 'return false for 2 space move with obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 6, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 4, y: 5, user_id: 5, game_id: 1)
      expect(white_pawn.move_to!(4, 4)).to eq(false)
    end

    it 'return false for 1 space move with obstruction' do
      white_pawn = create_white_pawn(x: 4, y: 4, user_id: 4, game_id: 1)
      black_pawn = create_black_pawn(x: 4, y: 3, user_id: 5, game_id: 1)
      expect(white_pawn.move_to!(4, 3)).to eq(false)
    end
  end

  describe 'en_passant' do
    it 'should update piece state to en passant for the first move' do
      white_pawn = create_white_pawn(x: 2, y: 2, user_id: 4, game_id: 1)
      white_pawn.move_to!(2,4)

      expect(white_pawn.en_passant).to eq(true)

      white_pawn.move_to!(2,5)

      expect(white_pawn.en_passant).to eq(false)
    end
  end
end
