class Player
  attr_acessor :name, :score, :lives, :is_active

  def initialize(name, score = 0, lives = 3)
    @name = name
  end

  def alive?
    @lives > 0
  end


end
