require 'pry'
require 'byebug'
require_relative 'player'
require 'colorize'

# @player_stats = {
#   player_1: {
#     name: "player_1",
#     score: 0,
#     lives: 3
#   },
#   player_2: {
#     name: "player_2",
#     score: 0,
#     lives: 3
#   }
# }
@players = []
OUTPUT_COLORS = String.colors

def play_round(player)
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = ["+","-","/","*"].sample
  answer = eval("#{num1}#{operator}#{num2}").round(2)
  #byebug
  player_answer = prompt("#{player.name}: What is #{num1}" +
   "#{operator} #{num2}? it's #{answer}", OUTPUT_COLORS[active_player]).to_f
  player_answer == answer #returns true if correct, false if wrong
end

def update_stats(player, round_result)
  #byebug
  if round_result
    player.score += 1
  else
    player.lives -= 1
  end
end

def prompt(string, color = :white)
  puts string.colorize(color)
  gets.chomp
end

def lost_game()
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

def get_player_names(num_players)
  num_players.times do |num|
    name = prompt("Player #{num + 1}, what's your name?")
    @players << Player.new(name)
  end
end

def active_player()
  @players.find_index{|i| i.is_active}
end

def get_next_player()

  if active_player < @players.length - 1
    set_active_player(active_player + 1)
  else
    set_active_player(0)
  end
end

def new_game()

  #if integet or float, will convert to integer. if non-number string, will
  #convert to 0
  number_players = prompt("Thanks for choosing to play this guessing game! " +
    "How many players will be playing?").to_i
  if number_players > 1
    get_player_names(number_players)
    return true
  else
    puts "Let's try this again when you bring a friend."
    return false
  end
end

def play_game()
  if @players.empty?
    return if !new_game() #exits if new_game is not sucessful
    @players[0].is_active = true
    wants_to_play = "y"
  else
    set_active_player(0)
    wants_to_play = prompt("Would you like to play another game? (y/n)").downcase
    @players.each{|player| player.lives = 3} #resets the lives to 3
  end

  case wants_to_play
  when "y"
    while lost_game.nil? do
      round_result = play_round(@players[active_player])
      update_stats(@players[active_player], round_result)
      get_next_player
    end
    puts "Sorry #{lost_game.name}, you lost. "
    @players.each do |player|
      puts "#{player.name} finished with #{player.score.to_s} points."
    end
    play_game
  when "n"
    return
  end
end

#pp String.colors
#pp play_round(@player_stats[:player_2])
pp play_game()
