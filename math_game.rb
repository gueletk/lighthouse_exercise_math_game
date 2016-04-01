require 'pry'
require 'byebug'
require_relative 'player'

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

def play_round(player)
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = ["+","-","/","*"].sample
  answer = eval("#{num1}#{operator}#{num2}").round(2)
  player_answer = prompt("#{player.name}: What is #{num1} #{operator} #{num2}? it's #{answer}").to_f
  player_answer == answer #returns true if correct, false if wrong
end

def update_stats(player, round_result)
  if round_result
    player.score += 1
  else
    player.score -= 1
  end
end

def prompt(string)
  puts string
  gets.chomp
end

def lost_game()
  @players.each do |player|
    return player if !player.alive?
  end
end

def set_active_player(new_active_index)
  @players.each do |player|
    player.is_active = false
  end
  @players[new_active_index].is_active = false
end

def get_player_names(num_players)
  num_players.times do |num|
    name = prompt("Player #{num}, what's your name?")
    @players << Player.new(name)
  end
end

def active_player()
  @players.find_index{|i| i.is_active}
end

def get_next_player()
  case active_player
  when < @players.length - 2
    set_active_player(active_player + 1)
  else
    set_active_player(0)
  end
end



def play_game()
  if active_player == nil
    @players[0].is_active = true
    wants_to_play = prompt("Would you like to play a game? (y/n)").downcase
    get_player_names(2)
  else
    @current_player = :player_1
    wants_to_play = prompt("Would you like to play another game? (y/n)").downcase
    @player_stats.each{|player, data| data[:lives] = 3}
  end

  case wants_to_play
  when "y"
    while lost_game.nil? do
      round_result = play_round(@player_stats[@current_player])
      update_stats(@player_stats[@current_player], round_result)
      get_next_turn
    end
    puts "Sorry #{lost_game[:name]}, you lost. "
    @player_stats.each do |player, player_data|
      puts "#{player_data[:name]} finished with #{player_data[:score].to_s} points."
    end
    play_game
  when "n"
    return
  end
end

#pp play_round(@player_stats[:player_2])
pp play_game()
