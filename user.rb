class User < Gamer
  attr_accessor :name

  def initialize(name)
    @name = name
    super()
  end
end
