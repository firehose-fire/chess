class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces
  
  scope :available, -> { where(user_white_id: nil) }
end
