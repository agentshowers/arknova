require_relative 'cards.rb'
require_relative 'screenshot.rb'
require_relative 'upload.rb'

class CardDisplay
  include Screenshot
  include Upload

  def print
    text = "[#{name}](#{link}) ([screenshot](#{@upload_link}))\n"
    text << print_names
  end

  def print_names
    "- #{draw.map { |card| Cards.instance.get(card) }.join(", ")}\n"
  end

  def draw
    @draw ||= begin
      sample = cards.sample(size)
      sample = sample.sort if should_sort?
      sample
    end
  end

  def link
    @link ||= begin
      "https://ssimeonoff.github.io/ark-nova#{draw.join}"
    end
  end

end

class StartingHand < CardDisplay
  def name
    "Starting Hand"
  end

  def cards
    Cards::ANIMALS.to_a + Cards::SPONSORS.to_a + Cards::CONSERVATION_PROJECTS.to_a
  end

  def size
    8
  end

  def screenshot_dimensions
    "1200,800"
  end

  def should_sort?
    true
  end
end

class ScoringCards < CardDisplay
  def name
    "Scoring Cards"
  end

  def cards
    Cards::SCORING_CARDS.to_a
  end

  def size
    2
  end

  def screenshot_dimensions
    "800,400"
  end

  def should_sort?
    true
  end
end

class BaseProjects < CardDisplay
  def name
    "Base Projects"
  end

  def cards
    Cards::BASE_CPS.to_a
  end

  def size
    4
  end

  def screenshot_dimensions
    "1200,400"
  end

  def should_sort?
    false
  end

  def print_names
    text = ""
    text << "- #{Cards.instance.get(draw[0])} (5cp blocked at 2 players)\n"
    text << "- #{Cards.instance.get(draw[1])} (#{Cards::FOUR_CP_PROJECTS.include?(draw[1]) ? 4 : 3}cp blocked at 2 players)\n"
    text << "- #{Cards.instance.get(draw[2])} (2cp blocked at 2 players)\n"
    text << "- #{Cards.instance.get(draw[3])} (4 players only)\n"
  end
end
