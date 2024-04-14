#!/usr/bin/env ruby

require 'json'

ANIMALS = 401..528
SPONSORS = 201..264
CONSERVATION_PROJECTS = 113..132
BASE_CPS = 101..112
SCORING_CARDS = 1..11
ACTIONS = ["Association", "Cards", "Sponsors", "Build"]
CARDS = JSON.parse(File.read("cards.json"))
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

def id(card_number)
  "##{card_number.to_s.rjust(3, '0')}"
end

def generate_link(cards)
  ids = cards.map { |card| id(card) }.join
  "https://ssimeonoff.github.io/ark-nova#{ids}"
end

def generate_names(cards)
  cards.map { |card| CARDS[id(card)] }
end

def ordinalize(number)
  if (11..13).include?(number % 100)
    "#{number}th"
  else
    case number % 10
    when 1
      "#{number}st"
    when 2
      "#{number}nd"
    when 3
      "#{number}rd"
    else
      "#{number}th"
    end
  end
end

starting_hand = (ANIMALS.to_a + SPONSORS.to_a + CONSERVATION_PROJECTS.to_a).sample(8).sort
scoring_cards = SCORING_CARDS.to_a.sample(2)
base_projects = BASE_CPS.to_a.sample(4)
map = (0..9).to_a.sample
bonus_tiles = BONUS_TILES.sample(4)
card_slots = (1..4).map { |n| [n, ACTIONS.shuffle.join(" | ")] }.to_h

#  Hi everyone! The Starting hand of the week is a popular post on r/TerraformingMarsGame, so decided to try it out over here. If this becomes popular, I'll make it a regular weekly thing. Any feedback and comments are appreciated!
# puts "---"
puts "### Setup"
puts ""
puts "[Map](https://raw.githubusercontent.com/agentshowers/arknova/main/maps/#{map+1}.png)"
puts "- #{MAPS[map]}"
puts ""
puts "[Starting hand](#{generate_link(starting_hand)})"
puts "- #{generate_names(starting_hand).join(", ")}"
puts ""
puts "[Scoring cards](#{generate_link(scoring_cards)})"
puts "- #{generate_names(scoring_cards).join(", ")}"
puts ""
puts "[Base projects](#{generate_link(base_projects)})"
puts "- #{CARDS[id(base_projects[0])]}"
puts "- #{CARDS[id(base_projects[1])]}"
puts "- #{CARDS[id(base_projects[2])]}"
puts "- #{CARDS[id(base_projects[3])]} (4 players only)"
puts ""
puts "Conservation Bonus"
puts "- **5 CP**: #{bonus_tiles[0]} / #{bonus_tiles[1]}"
puts "- **8 CP**: #{bonus_tiles[2]} / #{bonus_tiles[3]}"
puts ""
puts "---"
puts ""
puts "### Player order and card slots"
puts ""
(1..4).each do |player_count|
  order = (1..player_count).to_a.shuffle
  if player_count == 1
    puts "Solo"
  else
    puts "#{player_count} players (#{ordinalize(order.index(1) + 1)})"
  end
  order.each_with_index do |n, i|
    if n == 1
      puts "- **Animals | #{card_slots[n]}**" 
    else
      puts "- Animals | #{card_slots[n]}"
    end
  end
  puts ""
end
