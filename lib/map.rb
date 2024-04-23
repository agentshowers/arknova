class Map
  MAPS = [
    "Observation Tower",
    "Outdoor Areas",
    "Silver Lake",
    "Commercial Harbor",
    "Park Restaurant",
    "Research Institute",
    "Ice Cream Parlors",
    "Hollywood Hills",
    "Geographical Zoo",
    "Rescue Station"
  ]

  def initialize
    @map = (0..9).to_a.sample
  end

  def print
    text = "[Map](https://raw.githubusercontent.com/agentshowers/arknova/main/maps/#{@map+1}.png)\n"
    text << "- #{MAPS[@map]}\n"
    text
  end
end