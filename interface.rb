class Interface
  attr_accessor :game

  def register_user
    puts 'Black Jack Game'
    puts '=' * 80
    puts 'Input your name: '
    @user_name = gets.strip
    @game = Game.new(@user_name)
  end

  def choose_action
    puts 'Choose action: '
    puts '1 - Miss'
    puts '2 - Take card'
    puts '3 - Open cards'
  end

  def start
    register_user
    loop do
      show_cards
      choose_action
      input = gets.strip.to_i
      case input
      when 1
        game.dealer_turn if game.dealer.score < 17
        deal_cycle
      when 2
        game.take_card(game.user)
        game.dealer_turn
        game.deal_result? ? deal_cycle : show_cards
      when 3 then deal_cycle
      else
        puts 'Wrong input. Please, choose 1, 2 or 3.'
      end
    end
  end

  def deal_cycle
    game.open_cards
    show_cards_when_open
    show_money
    play_again
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
    print "#{card.name}#{card.suit} "
  end

  def hidden_dealer_card(amount)
    print '* ' * amount
  end

  def show_cards
    show_user_cards(game.user, game.user.score)
    game.user.used_cards.each { |card| show_card(card) }
    puts
    show_dealer_cards
    hidden_dealer_card(game.dealer.used_cards.size)
    puts
  end

  def show_cards_when_open
    show_user_cards(game.user, game.user.score)
    game.user.used_cards.each { |card| show_card(card) }
    puts
    show_dealer_cards(game.dealer.score)
    game.dealer.used_cards.each { |card| show_card(card) }
    puts
  end

  def show_players_money(user, dealer)
    puts "#{user.name} money: #{user.money}"
    puts "Dealer money: #{dealer.money}"
    puts '=' * 80
  end

  def show_money
    show_players_money(game.user, game.dealer)
  end

  def play_again
    puts 'Play again? (input: Y/N)'
    input = gets.strip.downcase
    input == 'y' ? game.deal : abort
  end
end
