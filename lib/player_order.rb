class PlayerOrder
  ACTIONS = ["Association", "Cards", "Sponsors", "Build"]

  def initialize
    @card_slots = (1..4).map { |n| [n, ACTIONS.shuffle.join(" | ")] }.to_h
  end

  def print
    text = "### Player order and card slots\n\n"
    (1..4).each do |player_count|
      order = (1..player_count).to_a.shuffle
      if player_count == 1
        text << "Solo\n"
      else
        text << "#{player_count} players (#{ordinalize(order.index(1) + 1)})\n"
      end
      order.each_with_index do |n, i|
        if n == 1
          text <<  "- **Animals | #{@card_slots[n]}**\n" 
        else
          text <<  "- Animals | #{@card_slots[n]}\n"
        end
      end
      text << "\n"
    end
    text
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