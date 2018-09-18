class Piece < ApplicationRecord
  belongs_to :game , optional: true
  belongs_to :user , optional: true



  def captured?(new_x, new_y)
    target_move = Piece.where(coordinate_x: new_x, coordinate_y: new_y).first

    if(target_move.user_id == self.user_id)
      raise RuntimeError
    else
      target_move.update_attributes(coordinate_x: nil, coordinate_y: nil, captured: true)
    end
  end


  def move_to!(new_x, new_y)

    captured?(new_x, new_y) ? update_attributes(coordinate_x: new_x, coordinate_y: new_y) : nil
  end



end
