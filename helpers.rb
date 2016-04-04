require 'colorize'

module Helpers
  OUTPUT_COLORS = String.colors.reverse - [:white, :light_white, :light_black, :black, :default]

  def prompt(string, color = :white)
    puts string.colorize(color)
    gets.chomp
  end
  
end
