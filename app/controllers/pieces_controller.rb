class PiecesController < ApplicationController

  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
  end

  def update
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game 
    @selected_piece.move_to!(params[:piece][:coordinate_x].to_i, params[:piece][:coordinate_y].to_i)
  end

  def castle_queen
    @selected_piece = Piece.find(params[:rookid])
    @selected_piece.castle_queenside!
    render :json => {}
  end

  def castle_king
    @selected_piece = Piece.find(params[:rookid])
    @selected_piece.castle_kingside!
    render :json => {}
  end

  private

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

end
