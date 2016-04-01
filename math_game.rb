require 'pry'

@player_stats = {
  player_1: {
    name: "player1",
    score: 0,
    lives: 3
  },
  player_2: {
    name: "player2",
    score: 0,
    lives: 3
  }
}

@current_player = :player_1

def play_round(player)
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = ["+","-","/","*"].sample
  answer = eval("#{num1}#{operator}#{num2}").round(2)
  player_answer = prompt("#{player[:name]}: What is #{num1} #{operator} #{num2}? it's #{answer}").to_f
  player_answer == answer #returns true if correct, false if wrong
end

def prompt(string)
  puts string
  gets.chomp
end

def get_player_names()
  @player_stats[:player_1][:name] = prompt("Player 1, what's your name?")
  @player_stats[:player_2][:name] = prompt("Player 2, what's your name?")
end

def get_next_turn()
  if @current_player == :player_1
    @current_player = :player_2
  else
    @current_player = :player_1
  end
end

def lost_game?()
  if @player_stats[:player_1][:score] == 0
    return @player_stats[:player_1]
  elsif @player_stats[:player_2][:score] == 0
    return @player_stats[:player_1]
end

def play_game()
  wants_to_play = prompt("Would you like to play a game? (y/n)").downcase
  case wants_to_play
  when "y"
    get_player_names()
    play_r
  when "n"
    return
  end
end

#pp play_round(@player_stats[:player_2])
pp play_game()
