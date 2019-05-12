class Game
  attr_reader :interface, :user, :dealer, :deck, :bank

  BET = 10

  def start
    @interface = Interface.new
    user_name = interface.receive_name
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
    manage_game
  end

  def manage_game
    loop do
      input = interface.choose_action
      case input
      when 1 then dealer_turn
      when 2 then add_card
      when 3 then open_cards
      else
        puts 'Wrong input. Please, choose 1, 2 or 3.'
      end
    end
  end

  def take_card(gamer)
    return if deck.cards.empty?

    gamer.used_cards << deck.cards.pop
  end

  def show_cards
    interface.show_user_cards(user, user.score)
    user.used_cards.each { |card| interface.show_card(card) }
    puts
    interface.show_dealer_cards
    interface.hidden_dealer_card(dealer.used_cards.size)
    puts
  end

  def show_money
    interface.show_money(user, dealer)
  end

  def dealer_turn
    take_card(dealer) if dealer.score < 17
    if user.used_cards.size == 3 || dealer.used_cards.size == 3
      open_cards
    else
      show_cards
    end
    manage_game
  end

  def add_card
    take_card(user)
    dealer_turn
  end

  def open_cards
    user_points = user.score
    dealer_points = dealer.score
    interface.show_user_cards(user, user_points)
    user.used_cards.each { |card| interface.show_card(card) }
    puts
    interface.show_dealer_cards(dealer_points)
    dealer.used_cards.each { |card| interface.show_card(card) }
    puts
    count_money(user_points, dealer_points)
    show_money
    ask_question
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

  def ask_question
    input = interface.play_again
    deal if input == 'y'
    abort
  end
end
