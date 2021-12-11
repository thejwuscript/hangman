# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'player.rb'
require_relative 'cmd_text.rb'
require 'io/console'


game = Game.new

game.play