#!/usr/bin/env ruby

require 'nokogiri'
require 'json'

HTML_FILE = 'tmp/ark-nova.html'

%x{ curl https://ssimeonoff.github.io/ark-nova > #{HTML_FILE} }

html = open(HTML_FILE)
doc = Nokogiri::HTML(html)

cards = {}
doc.css('li').each do |li|
  number = li.css('.number').text
  name = li.css('.name').text
  cards[number] = name
end

File.write("cards.json", cards.to_json)