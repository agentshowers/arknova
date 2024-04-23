#!/usr/bin/env ruby

require_relative 'lib/bonus_tiles.rb'
require_relative 'lib/card_display.rb'
require_relative 'lib/map.rb'
require_relative 'lib/player_order.rb'
require_relative 'lib/screenshot.rb'

Screenshot.setup if ENV["GITHUB_RUN_ID"]

starting_hand = StartingHand.new
puts "Taking screenshot of starting hand"
Screenshot.take(starting_hand.link, "starting_hand")

text = "### Setup\n\n"
text << Map.new.print
text << "\n"
text << starting_hand.print
text << "\n"
text << ScoringCards.new.print
text << "\n"
text << BaseProjects.new.print
text << "\n"
text << BonusTiles.new.print
text << "\n---\n\n"
text << PlayerOrder.new.print

File.write("post.md", text)