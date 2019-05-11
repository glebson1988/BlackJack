class Game
  attr_reader :interface, :user, :dealer, :deck, :bank

  BET = 10

  def initialize
    @interface = Interface.new
    user_name = Interface.receive_name
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
      # TODO
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
end
