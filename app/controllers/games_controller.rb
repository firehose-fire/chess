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
    # will update  user_white_id: 11 to current_user.id when log in is set up.
    if @game.update(user_white_id: 11)
      
    redirect_to root_path
    end

  end


  
end
