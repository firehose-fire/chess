class GamesController < ApplicationController

  def new
  end

  def index
  end

  def create
  end

  def show
  end

  def update
    @game = Games.find(params[:id])

    if @game.update(:user_white_id => current_user.id)
      redirect_to @game
    end
  end
  
end
