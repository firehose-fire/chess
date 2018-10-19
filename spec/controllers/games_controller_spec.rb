require 'rails_helper'


RSpec.describe GamesController, type: :controller do

  describe "games#update action" do
    it "should update available game user white id with current user id" do
      
      user = FactoryBot.create(:user)
      current_user = FactoryBot.create(:user)
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)
      game = FactoryBot.create(:game, user_black_id: user.id)
      patch :update, params: { id: game.id, user_white_id: current_user.id }
      game.reload
      
      expect(game.user_white_id).to eq current_user.id
    end

  end

  describe "games#destroy action" do
    it "should delete the current game and get redirected" do

      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user_black_id: user.id)

      game.destroy


      expect(response).to have_http_status(200)
    end
  end


end
