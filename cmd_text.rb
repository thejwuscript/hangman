# frozen_string_literal: true

module CmdText
  def welcome_message
    system('clear')
    puts "Welcome to \e[41m\e[1m\e[4mHANGMAN\e[24m\e[22m\e[0m."
    puts 'Guess a secret word by guessing one letter at a time.'
    puts '(Press any key to continue...)'
    STDIN.getch
  end

  def load_message
    puts 'Would you like to load a saved game? [y/n]'
  end

  def one_letter
    puts 'Too many letters. Please enter only one letter.'
  end

  def no_num_special_chars
    puts 'No numbers or special characters. Please enter one letter.'
  end

  def no_repeats
    puts 'No repeat guesses. Please try again.'
  end

  def prompt_player_guess
    print 'Guess: '
  end

  def show_losing_message
    puts "Oh no, you ran out of health! The secret word is '#{secret_word}'."
  end

  def show_winning_message
    puts 'You got it! Congratulations.'
  end

  def encourage
    'Great guess, keep it up!'
  end

  def lose_health_message
    "Letter '#{player.guess}' is not in the word! Lose 1 health :("
  end

  def feedback
    if all_guesses != ''
      secret_word.include?(player.guess) ? encourage : lose_health_message
    end
  end
end
