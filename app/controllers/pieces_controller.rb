class PiecesController < ApplicationController

  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
    # render "games/show"
  end

  def update
    # @selected_piece = Piece.find(params[:id, :coordinate_x, :coordinate_y])
    piece.update_attribute(:coordinate_x, :coordinate_y)
    redirect_to game_path
  end


  private

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

end
