class Game < ApplicationRecord
  belongs_to :user_white, class_name: 'User'
  belongs_to :user_black, class_name: 'User'

  has_many :pieces
  
  scope :available, -> { where(user_white_id: nil) }
end
