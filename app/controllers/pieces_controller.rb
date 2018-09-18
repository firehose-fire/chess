class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @piece_col = @piece.coordinate_x
    @piece_row = @piece.coordinate_y
    # render "games/show"
    redirect_to game_path
  end

  def update
    @piece.update_attributes(:coordinate_x, :coordinate_y)
  end

  private

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

end
