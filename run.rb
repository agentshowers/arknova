#!/usr/bin/env ruby

require_relative 'lib/bonus_tiles.rb'
require_relative 'lib/card_display.rb'
require_relative 'lib/map.rb'
require_relative 'lib/player_order.rb'
require_relative 'lib/screenshot.rb'

Screenshot.github_setup if ENV["GITHUB_RUN_ID"]

starting_hand = StartingHand.new
puts "Taking screenshot of starting hand"
Screenshot.take(starting_hand)

scoring_cards = ScoringCards.new
puts "Taking screenshot of scoring cards"
Screenshot.take(scoring_cards)

base_projects = BaseProjects.new
puts "Taking screenshot of base projects"
Screenshot.take(base_projects)

text = "### Setup\n\n"
text << Map.new.print
text << "\n"
text << starting_hand.print
text << "\n"
text << scoring_cards.print
text << "\n"
text << base_projects.print
text << "\n"
text << BonusTiles.new.print
text << "\n---\n\n"
text << PlayerOrder.new.print

File.write("post.md", text)