require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'populate_game' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)

    game = FactoryBot.create(:game, user_white_id: user1.id, user_black_id: user2.id)
    game.populate_the_game
    expect(game.populate_the_game).to be_valid

    # Pawn test for black and white pieces
    expect(game.piece_at(0, 1)).to have_attributes(type: 'Pawn', piece_color: 'black')
    expect(game.piece_at(0, 6)).to have_attributes(type: 'Pawn', piece_color: 'white')

    # King test for black and white pieces
    expect(game.piece_at(4, 0)).to have_attributes(type: 'King', piece_color: 'black')
    expect(game.piece_at(4, 7)).to have_attributes(type: 'King', piece_color: 'white')

    # Bishop test for black and white pieces
    expect(game.piece_at(2, 0)).to have_attributes(type: 'Bishop', piece_color: 'black')
    expect(game.piece_at(2, 7)).to have_attributes(type: 'Bishop', piece_color: 'white')

    # Rook test for black and white pieces
    expect(game.piece_at(0, 0)).to have_attributes(type: 'Rook', piece_color: 'black')
    expect(game.piece_at(0, 7)).to have_attributes(type: 'Rook', piece_color: 'white')

    # Knight test for black and white pieces
    expect(game.piece_at(1, 0)).to have_attributes(type: 'Knight', piece_color: 'black')
    expect(game.piece_at(1, 7)).to have_attributes(type: 'Knight', piece_color: 'white')

    # Queen test for black and white pieces
    expect(game.piece_at(3, 7)).to have_attributes(type: 'Queen', piece_color: 'black')
    expect(game.piece_at(3, 0)).to have_attributes(type: 'Queen', piece_color: 'white')

  end

  describe "is check for the king" do
    it "should see if the king is in a check position " do
      user_black = FactoryBot.create(:user)
      user_white = FactoryBot.create(:user)

      game = FactoryBot.create(:game, user_white_id: user_white.id, user_black_id: user_black.id)
      king = FactoryBot.create(:king, coordinate_x: 4, coordinate_y: 3, user_id: user_black.id)
      piece = FactoryBot.create(:piece, coordinate_x: 3, coordinate_y: 3, user_id: user_white.id)

      piece.move_to!(4,3)

      expect(game.is_check?(user_black.id)).to eq(true)


    end
  end

end
