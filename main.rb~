require 'pry'
require 'byebug'
require_relative 'player'
require_relative 'helpers'
require_relative 'math_game'
require 'colorize'

include Helpers

def start_playing
  game_mode = Helpers::prompt("Thanks for choosing to play this guessing game! " +
    "Would you like to play in easy mode (adding), hard mode (adding, " +
    "subtraction, multiplication), or super hard mode (all operations)? " +
    "(easy/hard/super)").downcase

  if MathGame.get_game_modes.include?(game_mode)
    @math_game = MathGame.new(game_mode)
    play_math_game
  else
    puts "Sorry, that's not one of the options, let's try again."
    start_playing
  end
end

def play_math_game()

  wants_to_play = ""

  begin
  @math_game.play_game

  wants_to_play = Helpers::prompt("Would you like to play another game? (y/n)").downcase
  end until wants_to_play == "n"

end

#pp String.colors
#pp play_round(@player_stats[:player_2])
pp start_playing()
