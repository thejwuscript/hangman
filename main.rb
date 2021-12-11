# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'player'
require_relative 'cmd_text'
require 'io/console'

game = Game.new

game.play
