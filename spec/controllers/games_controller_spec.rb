require 'rails_helper'


RSpec.describe GamesController, type: :controller do

  describe "games#update action" do
    it "should update available game user white id with current user id" do
      
      user = FactoryBot.create(:user)
      
      # sign_in user

      game = FactoryBot.create(:game, user_black_id: '3')

      patch :update, params: { user_white_id: user.id}

      expect(user_white_id).to eq user.id
    end

  end

end
