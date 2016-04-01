class Player
  attr_accessor :name, :score, :lives, :is_active

  def initialize(name, score = 0, lives = 3)
    @name = name
    @score = score
    @lives = lives
  end

  def alive?
    @lives > 0
  end


end
