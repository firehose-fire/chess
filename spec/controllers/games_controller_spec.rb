require 'rails_helper'


RSpec.describe GamesController, type: :controller do

  describe "games#update action" do
    it "should update available game user white id with current user id" do
      
      user = FactoryBot.build(:user)
      current_user = FactoryBot.build(:user)
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)
      game = FactoryBot.build(:game, user_black_id: user.id)
      # patch :update, params: { user_white_id: current_user.id}
      patch :update, params: { id: game.id }
      game.reload
      
      expect(game.user_white_id).to eq current_user.id
    end

  end

end
