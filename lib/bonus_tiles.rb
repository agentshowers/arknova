class BonusTiles
  BONUS_TILES = [
    "2 reputation",
    "x2 token",
    "3 **X** tokens",
    "Size 3 enclosure",
    "10 money",
    "Draw 3 cards",
    "Play sponsors",
    "University",
    "Partner Zoo"
  ]

  def initialize
    @tiles = BONUS_TILES.sample(4)
  end

  def print
    text = "Conservation Bonus\n"
    text << "- **5 CP**: #{@tiles[0]} / #{@tiles[1]}\n"
    text << "- **8 CP**: #{@tiles[2]} / #{@tiles[3]}\n"
    text
  end
end