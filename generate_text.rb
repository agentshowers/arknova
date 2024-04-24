#!/usr/bin/env ruby

require_relative "lib/bonus_tiles.rb"
require_relative "lib/card_display.rb"
require_relative "lib/map.rb"
require_relative "lib/player_order.rb"
require_relative "lib/screenshot.rb"
require 'dotenv'

if ENV["GITHUB_RUN_ID"]
  Screenshot.github_setup
else
  Dotenv.load
end

starting_hand = StartingHand.new
puts "Taking screenshot of starting hand"
starting_hand.screenshot
puts "Uploading screenshot"
link = starting_hand.upload
puts "Image at #{link}"

scoring_cards = ScoringCards.new
puts "Taking screenshot of scoring cards"
scoring_cards.screenshot
puts "Uploading screenshot"
link = scoring_cards.upload
puts "Image at #{link}"

base_projects = BaseProjects.new
puts "Taking screenshot of base projects"
base_projects.screenshot
puts "Uploading screenshot"
link = base_projects.upload
puts "Image at #{link}"

puts "Generating text"

if ENV["INTRO_MESSAGE"]
  text = ENV["INTRO_MESSAGE"]
  text << "\n---\n\n"
else
  text = ""
end

text << "### Setup\n\n"
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

puts text

File.write("post.md", text)