#!/usr/bin/env ruby

require 'json'

ANIMALS = 401..528
SPONSORS = 201..264
CONSERVATION_PROJECTS = 113..132
BASE_CPS = 101..112
SCORING_CARDS = 1..11
ACTIONS = ["Association", "Cards", "Sponsors", "Build"]
CARDS = JSON.parse(File.read("cards.json"))

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
actions = ACTIONS.shuffle

puts "[Starting hand](#{generate_link(starting_hand)})"
puts "- #{generate_names(starting_hand).join(", ")}"
puts ""
puts "[Scoring cards](#{generate_link(scoring_cards)})"
puts "- #{generate_names(scoring_cards).join(", ")}"
puts ""
puts "[Base projects](#{generate_link(base_projects)})"
puts "- #{CARDS[id(base_projects[0])]} (Highest CP blocked at 2 players)"
puts "- #{CARDS[id(base_projects[1])]} (Middle CP blocked at 2 players)"
puts "- #{CARDS[id(base_projects[2])]} (Lowest CP blocked at 2 players)"
puts "- #{CARDS[id(base_projects[3])]} (only at 4 players)"
puts ""
puts "|Slot|Action|"
puts "|:-|:-|"
puts "|1|Animals|"
(1..4).each do |n|
  puts "|#{n+1}|#{actions[n-1]}|"
end
puts ""
puts "|Players|Order|"
puts "|:-|:-|"
(1..4).each do |player_count|
  puts "|#{player_count}|#{ordinalize((1..player_count).to_a.sample)}|"
end
