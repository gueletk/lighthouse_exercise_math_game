class MathGame

  attr_reader :players
  attr_accessor :game_mode

  WIN_COLOR = :green
  LOSE_COLOR = :red

  def initialize (game_mode, num_players = 2)
    @players = []
    @game_mode = game_mode
    generate_named_players(@players, num_players)
    reset_stats
  end

  def play_game
    begin
      round_result = play_round(players[active_player_index])
      update_stats(players[active_player_index], round_result)

      if round_result
        puts "Congratulations, that was correct. Your new scores are:".colorize(WIN_COLOR)
        display_scores
      else
        puts "Sorry, that was wrong. Your new scores are:".colorize(LOSE_COLOR)
        display_scores(players[active_player_index])
      end
      get_next_player
    end until losing_player
    puts "Sorry #{losing_player.name}, you lost.".colorize(LOSE_COLOR)
    display_scores(losing_player)
  end

  def reset_stats()
    set_active_player(0)
    players.each{|player| player.lives = 3}
  end

  def self.get_game_modes
    ["easy","hard","super"]
  end

  def generate_rand_math_question()
    num1 = rand(1..20)
    if game_mode == "easy"
      operator = "+"
    elsif game_mode == "hard"
      operator = ["+","-","*"].sample
    elsif game_mode == "super"
      operator = ["+","-","/","*"].sample
    end
    operator == "/" ? num2 = num1 * rand(1..10) : num2 = rand(1..20)
    "#{num2}#{operator}#{num1}"
  end

  def play_round(player)
    question = generate_rand_math_question
    answer = eval(question)
    player_answer = Helpers::prompt("#{player.name}: What is #{question}?",
    Helpers::OUTPUT_COLORS[active_player_index]).to_i

    player_answer == answer #returns true if correct, false if wrong
  end

  def update_stats(player, round_result)
    if round_result
      player.score += 1
    else
      player.lives -= 1
    end
  end

  def losing_player()
    losing_player = @players.find do |player|
      !player.alive?
    end
  end

  def set_active_player(new_active_index)
    @players.each do |player|
      player.is_active = false
    end
    @players[new_active_index].is_active = true
  end

  def generate_named_players(player_arr, num_players)
    num_players.times do |num|
      player_arr << Player.new(get_player_name(num))
    end
  end

  def get_player_name(num)
    Helpers::prompt("Player #{num + 1}, what's your name?")
  end

  def display_scores(red_player = nil)
    @players.each do |player|
      color = WIN_COLOR
      color = LOSE_COLOR if player == red_player
      puts "#{player.name} finished with #{player.score.to_s} ".colorize(color) +
      "point#{"s" if player.score != 1} and #{player.lives}".colorize(color) +
      " #{player.lives == 1 ? "life" : "lives"}.".colorize(color)
    end
  end

  def active_player_index()
    @players.find_index{|i| i.is_active}
  end

  def get_next_player()
    if active_player_index < @players.length - 1
      set_active_player(active_player_index + 1)
    else
      set_active_player(0)
    end
  end

end
