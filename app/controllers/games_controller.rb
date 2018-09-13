class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def create
  end

  def show
  end

  def update
    @game = Game.find(params[:id])
    if current_user 
      @game.update(user_white_id: current_user.id)     
    redirect_to root_path
    end
  end


  
end
