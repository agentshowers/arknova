#!/usr/bin/env ruby

require 'nokogiri'
require 'json'

html=%x{ curl https://ssimeonoff.github.io/ark-nova }
doc = Nokogiri::HTML(html)

cards = {}
doc.css('li').each do |li|
  number = li.css('.number').text
  name = li.css('.name').text
  cards[number] = name
end

File.write("cards.json", cards.to_json)