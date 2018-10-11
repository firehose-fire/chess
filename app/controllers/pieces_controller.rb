class PiecesController < ApplicationController

  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
  end

  def update
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
    @selected_piece.move_to!(params[:piece][:coordinate_x].to_i, params[:piece][:coordinate_y].to_i)
    # promotion_check
  end


  private

  # def promotion_check
  #  if @selected_piece.is_promotion?(:coordinate_y)
  #   @selected_piece.update(type: piece_params[:promotion_type])
  #  end
  # end

  def piece_params
    params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured)
  end

  # def piece_params
  #   params.require(:piece).permit(:id, :game_id, :user_id, :type, :coordinate_x, :coordinate_y, :piece_color, :captured, :promotion_type)
  # end
end
