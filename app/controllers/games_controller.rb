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
    @game = Game.find(params[:id])

    @game.update(user_white_id: current_user.id)

  end


  
end
