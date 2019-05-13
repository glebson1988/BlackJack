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
      choose_action
      input = gets.strip.to_i
      case input
      when 1 then game.dealer_turn
      when 2 then game.add_card
      when 3 then game.open_cards
      else
        puts 'Wrong input. Please, choose 1, 2 or 3.'
      end
    end
  end
end
