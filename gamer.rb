class Gamer
  attr_accessor :money, :used_cards

  START_BALANCE = 100

  def initialize
    @money = START_BALANCE
    @used_cards = []
  end

  def score
    total = used_cards.map(&:value).reduce(0, :+)

    if total > 21
      used_cards.count(&:ace?).times do
        total -= 10 if total > 21
      end
    end
    total
  end
end
