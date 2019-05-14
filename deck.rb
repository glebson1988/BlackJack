class Deck
  attr_reader :cards

  def initialize
    @cards = Card::SUITS.each_with_object([]) do |suit, cards|
      Card::RANK.each do |name, value|
        cards << Card.new(suit, name, value)
      end
    end
    cards.shuffle!
  end
end
