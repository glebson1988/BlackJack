class Game
  attr_reader :user, :dealer, :deck, :bank

  BET = 10

  def initialize(user_name)
    @user = User.new(user_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = Bank.new
    deal
  end

  def deal
    user.used_cards = []
    dealer.used_cards = []
    user.money -= BET
    dealer.money -= BET
    bank.money += BET * 2
    2.times { take_card(user) }
    2.times { take_card(dealer) }
    show_cards
  end

  def take_card(gamer)
    return if deck.cards.empty?

    gamer.used_cards << deck.cards.pop
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

  def show_players_money(user, dealer)
    puts "#{user.name} money: #{user.money}"
    puts "Dealer money: #{dealer.money}"
    puts '=' * 80
  end

  def show_cards
    show_user_cards(user, user.score)
    user.used_cards.each { |card| show_card(card) }
    puts
    show_dealer_cards
    hidden_dealer_card(dealer.used_cards.size)
    puts
  end

  def show_money
    show_players_money(user, dealer)
  end

  def dealer_turn
    take_card(dealer) if dealer.score < 17
    if user.used_cards.size == 3 || dealer.used_cards.size == 3
      open_cards
    else
      show_cards
    end
  end

  def add_card
    take_card(user)
    dealer_turn
  end

  def open_cards
    user_points = user.score
    dealer_points = dealer.score
    show_user_cards(user, user_points)
    user.used_cards.each { |card| show_card(card) }
    puts
    show_dealer_cards(dealer_points)
    dealer.used_cards.each { |card| show_card(card) }
    puts
    count_money(user_points, dealer_points)
    show_money
    play_again
  end

  def take_money(gamer, money)
    gamer.money += money
  end

  def bank_zero
    bank.money = 0
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def spot_winner(user_points, dealer_points)
    nil if dealer_points == user_points
    nil if dealer_points > 21 && user_points > 21
    return user if dealer_points > 21
    return dealer if user_points > 21

    dealer_points > user_points ? dealer : user
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def count_money(user_points, dealer_points)
    winner = spot_winner(user_points, dealer_points)
    if winner
      take_money(winner, bank.money)
    else
      take_money(user, bank.money / 2)
      take_money(dealer, bank.money / 2)
    end
    bank_zero
  end

  def play_again
    puts 'Play again? (input: Y/N)'
    input = gets.strip.downcase
    input == 'y' ? deal : abort
  end
end
