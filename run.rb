#!/usr/bin/env ruby

require_relative 'lib/bonus_tiles.rb'
require_relative 'lib/card_display.rb'
require_relative 'lib/map.rb'
require_relative 'lib/player_order.rb'

text = "### Setup\n\n"
text << Map.new.print
text << "\n"
text << StartingHand.new.print
text << "\n"
text << ScoringCards.new.print
text << "\n"
text << BaseProjects.new.print
text << "\n"
text << BonusTiles.new.print
text << "\n---\n\n"
text << PlayerOrder.new.print

File.write("post.md", text)