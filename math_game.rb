require 'pry'
require 'byebug'

@player_stats = {
  player_1: {
    name: "player_1",
    score: 0,
    lives: 3
  },
  player_2: {
    name: "player_2",
    score: 0,
    lives: 3
  }
}

@current_player = nil

def play_round(player)
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = ["+","-","/","*"].sample
  answer = eval("#{num1}#{operator}#{num2}").round(2)
  player_answer = prompt("#{player[:name]}: What is #{num1} #{operator} #{num2}? it's #{answer}").to_f
  player_answer == answer #returns true if correct, false if wrong
end

def assign_score(player, round_result)
  if round_result
    player[:score] += 1
  else
    player[:lives] -= 1
  end
end

def prompt(string)
  puts string
  gets.chomp
end

def lost_game()
  if @player_stats[:player_1][:lives] == 0
    return @player_stats[:player_1]
  elsif @player_stats[:player_2][:lives] == 0
    return @player_stats[:player_1]
  else
    return nil
  end
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



def play_game()
  if @current_player == nil
    @current_player = :player_1
    wants_to_play = prompt("Would you like to play a game? (y/n)").downcase
    get_player_names()
  else
    @current_player = :player_1
    wants_to_play = prompt("Would you like to play another game? (y/n)").downcase
    @player_stats.each{|player, data| data[:lives] = 3}
  end

  case wants_to_play
  when "y"
    while lost_game.nil? do
      round_result = play_round(@player_stats[@current_player])
      assign_score(@player_stats[@current_player], round_result)
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
