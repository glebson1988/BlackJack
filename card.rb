class Card
  attr_reader :suit, :name, :value

  SUITS = %i[♣ ♦ ♥ ♠].freeze
  RANK = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    :jack => 10,
    :queen => 10,
    :king => 10,
    :ace => 10
  }.freeze

  def initialize(suit, name, value)
    @suit = suit
    @name = name
    @value = value
  end

  def ace?
    true if name == :ace
  end
end