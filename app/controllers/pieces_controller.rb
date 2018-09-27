class PiecesController < ApplicationController

  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
  end

  def update
    @selected_piece = Piece.find(params[:id])
    @selected_piece.update_attribute(:coordinate_x, params[:piece][:coordinate_x].to_i)
    @selected_piece.update_attribute(:coordinate_y, params[:piece][:coordinate_y].to_i)
    byebug
    @game = @selected_piece.game
    redirect_to game_path(@game)
  end


  private

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

end
