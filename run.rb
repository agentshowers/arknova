#!/usr/bin/env ruby

require_relative 'lib/bonus_tiles.rb'
require_relative 'lib/card_display.rb'
require_relative 'lib/map.rb'
require_relative 'lib/player_order.rb'

puts "### Setup"
puts ""

Map.new.print
StartingHand.new.print
ScoringCards.new.print
BaseProjects.new.print
BonusTiles.new.print

puts "---"
puts ""

PlayerOrder.new.print