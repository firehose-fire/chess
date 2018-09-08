class Piece < ApplicationRecord
  belongs_to :games
  belongs_to :user

end
