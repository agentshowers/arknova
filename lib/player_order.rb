class PlayerOrder
  ACTIONS = ["Association", "Cards", "Sponsors", "Build"]

  def initialize
    @card_slots = (1..4).map { |n| [n, ACTIONS.shuffle.join(" | ")] }.to_h
  end

  def print
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
          puts "- **Animals | #{@card_slots[n]}**" 
        else
          puts "- Animals | #{@card_slots[n]}"
        end
      end
      puts ""
    end
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

end