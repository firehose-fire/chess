module GamesHelper

  def piece_image(type, color)
    image_tag "#{color}-#{type}.svg"
  end
end
