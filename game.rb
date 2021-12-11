# frozen_string_literal: true

require './display'
require './cmd_text'
require 'json'

# Class for the process of the game.
class Game
  attr_accessor :health, :wrong_guesses, :secret_word, :correct_guesses, :all_guesses
  attr_reader :player

  include Display
  include CmdText

  def initialize
    @health = '♥♥♥♥♥♥'
    @wrong_guesses = ''
    @correct_guesses = ''
    @all_guesses = ''
    @secret_word = ''
    @player = Player.new
  end

  def play
    prep_game unless load_game? == true
    rounds
    endgame
  end

  def load_game?
    load_message
    if gets.chomp.downcase == 'y'
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
    wordlist = File.open('dictionary1000.txt', 'r', &:readlines)
    loop do
      candidate = wordlist.sample
      next unless candidate.length >= 7 && candidate.length <= 14

      self.secret_word = candidate[0..-2].downcase
      break
    end
  end

  def rounds
    make_valid_guess
    evaluate_guess
    self.all_guesses = correct_guesses + wrong_guesses
    show_interface
    return if secret_word == secret_word.gsub(/[^#{correct_guesses}|.]/, ' ')

    return if health == ''

    rounds
  end

  def make_valid_guess
    prompt_player_guess
    player.guess = gets.chomp.downcase
    return if valid_guess? == true

    make_valid_guess
  end

  def valid_guess?
    case player.guess
    when 'save'
      save_to_json
      return
    when /[a-z]/
      return true unless all_guesses.include?(player.guess) || player.guess.length != 1
    end
    invalid_entry
  end

  def evaluate_guess
    if secret_word.include?(player.guess) == true
      self.correct_guesses += player.guess
    else
      self.wrong_guesses += " #{player.guess},"
      self.health = health.sub('♥', '')
    end
  end

  def endgame
    secret_word == letters.gsub(/\s/, '') ? show_winning_message : show_losing_message
    play_again?
  end

  def save_to_json
    File.open('save_state.json', 'w') do |file|
      JSON.dump({
                  health: @health,
                  wrong_guesses: @wrong_guesses,
                  correct_guesses: @correct_guesses,
                  secret_word: @secret_word
                }, file)
    end
    puts 'Game saved.'
  end

  def load_from_json
    hash = JSON.parse File.read('save_state.json')
    self.health = hash['health']
    self.wrong_guesses = hash['wrong_guesses']
    self.correct_guesses = hash['correct_guesses']
    self.secret_word = hash['secret_word']
  end

  def play_again?
    print 'Play again? [y/n] '
    gets.chomp.downcase == 'y' ? Game.new.play : puts('Thanks for playing.')
  end
end
