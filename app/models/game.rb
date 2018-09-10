class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces
  
  scope :available, -> { where(user_id_white: nil) }
end
