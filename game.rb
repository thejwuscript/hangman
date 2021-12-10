# frozen_string_literal: true

require './display.rb'
require './cmd_text.rb'
require 'json'

class Game
  attr_accessor :health, :wrong_guesses, :secret_word, :player,
                :correct_guesses, :all_guesses

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

  def invalid_entry
    if player.guess.length > 1
      one_letter
    elsif /[\p{P}\p{S}\p{N}]/.match?(player.guess)
      no_num_special_chars
    elsif all_guesses.include? player.guess
      no_repeats
    else
      puts 'Invalid entry. Please try again.'
    end
  end

  def evaluate_guess
    if secret_word.include?(player.guess) == true
      puts 'Great guess. Keep it up!'
      self.correct_guesses += player.guess
    else
      puts "Letter '#{player.guess}' is not in the word! -1 health :( "
      self.wrong_guesses += " #{player.guess},"
      self.health = health.sub('♥', '')
    end
  end

  def endgame
    puts "The secret word is '#{secret_word}'"
    puts 'Game over! Thanks for playing.'
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
    puts 'Game saved.'
  end

  def load_from_json
    hash = JSON.load File.read('save_state.json')
    self.health = hash['health']
    self.wrong_guesses = hash['wrong_guesses']
    self.correct_guesses = hash['correct_guesses']
    self.secret_word = hash['secret_word']
  end
end