# frozen_string_literal: true

require './display.rb'
require 'json'

class Game
  attr_accessor :health, :wrong_guesses, :secret_word, :player, :correct_guesses

  include Display

  def initialize
    @health = '♥♥♥♥♥♥'
    @wrong_guesses = ''
    @correct_guesses = ''
    @secret_word = ''
    @player = Player.new
  end

  def play
    prep_game unless load_game? == true
    rounds
    endgame
  end

  def load_game?
    puts "Load save state? (y/n)"
    if gets.chomp == 'y'
      load_from_json
      show_interface
      true
    else
      false
    end
  end


  def prep_game
    select_secret_word
    show_interface
  end

  def select_secret_word
    wordlist = File.open('5desk.txt', 'r') { |file| file.readlines }
    loop do
      candidate = wordlist.sample
      next unless candidate.length >= 7 && candidate.length <= 14

      self.secret_word = candidate[0..-3].downcase
      break
    end
  end

  def rounds
    make_valid_guess
    evaluate_guess
    show_interface
    return if secret_word == secret_word.gsub(/[^#{correct_guesses}|.]/, ' ')
    

    return if health == ''

    rounds
  end

  def make_valid_guess
    player.guess = gets.chomp.downcase
    if player.guess == 'save'
      save_to_json
      puts 'Game saved.'
      make_valid_guess
    end
  end
    # Player can only type in ONE. LETTER.
    # So no two or more characters
    # No numbers or special characters.
    # Cannot type in letters already guessed
  
  def evaluate_guess
    if secret_word.include?(player.guess) == true
      self.correct_guesses += player.guess
    else
      self.wrong_guesses += " #{player.guess},"
      self.health = health.sub('♥', '')
    end
  end

  def endgame
    puts "Game over! Thanks for playing."
  end

  def save_to_json
    path = 'save_state.json'
    File.open(path, 'w') do |file|
      JSON.dump({
        health: @health,
        wrong_guesses: @wrong_guesses,
        correct_guesses: @correct_guesses,
        secret_word: @secret_word
      }, file)
      end
  end

  def load_from_json
    hash = JSON.load File.read('save_state.json')
    p File.read('save_state.json')
    self.health = hash['health']
    self.wrong_guesses = hash['wrong_guesses']
    self.correct_guesses = hash['correct_guesses']
    self.secret_word = hash['secret_word']
  end
end