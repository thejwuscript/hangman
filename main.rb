# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'player'
require_relative 'cmd_text'
require 'io/console'

def welcome_message
  system('clear')
  puts "Welcome to \e[41m\e[1m\e[4mHANGMAN\e[24m\e[22m\e[0m."
  puts 'Guess a secret word by guessing one letter at a time.'
  puts '(Press any key to continue...)'
  $stdin.getch
end

game = Game.new
welcome_message
game.play
