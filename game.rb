class Game
  attr_reader :user, :dealer, :deck, :bank

  BET = 10

  def initialize(user_name)
    @user = User.new(user_name)
    @dealer = Dealer.new
    @bank = Bank.new
    deal
  end

  def deal
    @deck = Deck.new
    user.used_cards = []
    dealer.used_cards = []
    user.money -= BET
    dealer.money -= BET
    bank.money += BET * 2
    2.times { take_card(user) }
    2.times { take_card(dealer) }
  end

  def take_card(gamer)
    return if deck.cards.empty?

    gamer.used_cards << deck.cards.pop
  end

  def dealer_turn
    take_card(dealer) if dealer.score < 17
  end

  def deal_result?
    user.used_cards.size == 3 || dealer.used_cards.size == 3
  end

  def open_cards
    user_points = user.score
    dealer_points = dealer.score
    count_money(user_points, dealer_points)
  end

  def take_money(gamer, money)
    gamer.money += money
  end

  def bank_zero
    bank.money = 0
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def spot_winner(user_points, dealer_points)
    return nil if dealer_points == user_points
    return nil if dealer_points > 21 && user_points > 21
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
end
