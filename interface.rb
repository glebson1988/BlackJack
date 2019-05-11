class Interface
  def receive_name
    puts 'Input your name: '
    gets.strip
  end

  def choose_action
    puts 'Choose action: '
    puts '1 - Miss'
    puts '2 - Take card'
    puts '3 - Open cards'
    gets.strip.to_i
  end

  def show_user_cards(user, value = nil)
    puts "#{user.name} cards (#{value} points): "
  end

  def show_dealer_cards(value = nil)
    if value
      puts "Dealer cards (#{value} points): "
    else
      puts 'Dealer cards: '
    end
  end

  def show_card(card)
    print "#{card.name} #{card.suit}"
  end

  def hidden_dealer_card(amount)
    print '* ' * amount
  end

  def show_money(user, dealer)
    puts "#{user.name} money: #{user.money}"
    puts "Dealer money: #{dealer.money}"
  end

  def play_again
    puts 'Play again? (input: Y/N)'
    gets.strip.downcase
  end
end
