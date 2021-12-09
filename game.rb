# frozen_string_literal: true

require './display.rb'

class Game
  attr_accessor :health, :wrong_guesses, :secret_word, :player, :correct_guesses

  include Display

  def initialize
    @health = '♥♥♥♥♥♥'
    @wrong_guesses = ''
    @correct_guesses = '=>'
    @secret_word = ''
    @player = Player.new
  end

  def play
    prep_game
    rounds
    endgame
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
    return if secret_word == secret_word.gsub(/[^#{correct_guesses}]/, ' ')
    

    return if health == ''

    rounds
  end

  def make_valid_guess
    player.guess = gets.chomp.downcase
    # Player can only type in ONE. LETTER.
    # So no two or more characters
    # No numbers or special characters.
    # Cannot type in letters already guessed
  end

  def evaluate_guess
    if secret_word.include?(player.guess) == true
      self.correct_guesses += player.guess
    else
      self.wrong_guesses += " #{player.guess}" 
      self.health = health.sub('♥', '')
    end
  end

  def endgame
    puts "Game over! Thanks for playing."
  end

end

# display some sort of count so the player knows how many more incorrect guesses
# they have before the game ends. You should also display which correct letters
# have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g)
# and which incorrect letters have already been chosen.

# Every turn, allow the player to make a guess of a letter. It should be case insensitive.
# Update the display to reflect whether the letter was correct or incorrect.
# If out of guesses, the player should lose.

# Player loses on the 6th incorrect guess.
# Display "misses"
# Display correct letters and their position

# pre-game: extract the length of "secret word" and that will be the number of "_"
