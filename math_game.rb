require 'pry'

@player_stats = {
  player_1: {
    name: "player1",
    score: 0
  },
  player_2: {
    name: "player2",
    score: 0
  }
}

def play_round(player)
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = ["+","-","/","*"].sample
  answer = eval("#{num1}#{operator}#{num2}")
  puts "#{player[:name]}: What is #{num1} #{operator} #{num2}?"
end
