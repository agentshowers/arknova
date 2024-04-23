require 'singleton'
require 'json'

class Cards
  include Singleton

  def initialize
    @cards = JSON.parse(File.read("cards.json"))
  end

  def get(id)
    @cards[id]
  end

  def self.full_id(id)
    "##{id.to_s.rjust(3, '0')}"
  end

  ANIMALS = (401..528).to_a.map { |id| full_id(id) }
  SPONSORS = (201..264).to_a.map { |id| full_id(id) }
  CONSERVATION_PROJECTS = (113..132).to_a.map { |id| full_id(id) }
  BASE_CPS = (101..112).to_a.map { |id| full_id(id) }
  SCORING_CARDS = (1..11).to_a.map { |id| full_id(id) }
  # Australia and Europe + all animal projects
  FOUR_CP_PROJECTS = ([105] + (107..112).to_a).map { |id| full_id(id) }
end
