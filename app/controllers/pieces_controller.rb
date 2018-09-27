class PiecesController < ApplicationController

  def show
    @selected_piece = Piece.find(params[:id])
    byebug
    @game = @selected_piece.game
    byebug
  end

  def update
    byebug
    @selected_piece = Piece.find(params[:id])
    byebug
    @selected_piece.update_attribute(:coordinate_x, row)
    @selected_piece.update_attribute(:coordinate_y, column)
    @game = @selected_piece.game
    redirect_to game_path(@game)
  end


  private

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

end
