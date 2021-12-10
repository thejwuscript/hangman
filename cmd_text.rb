# frozen_string_literal: true

module CmdText
  def welcome_message
    puts 'Welcome to Hangman.'
    puts 'Guess a secret word by guessing one letter at a time.'
  end

  def load_message
    puts 'Would you like to load a saved game? [y/n]'
  end

  def one_letter
    puts 'Please enter only one letter.'
  end

  def no_num_special_chars
    puts 'No numbers or special characters. Please enter one letter.'
  end

  def no_repeats
    puts 'No repeat guesses. Please try again.'
  end

  def prompt_player_guess
    puts "Please enter one letter to make your guess. You may type 'save' to save the game."
    print 'Guess: '
  end

  def show_losing_message
    puts "Oh no, you ran out of health! The secret word is '#{secret_word}'."
  end

  def show_winning_message
    puts 'You got it! Congratulations.'
  end
end
