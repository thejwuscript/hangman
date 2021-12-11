# frozen_string_literal: true

# Module for player instructions, comments and feedback.
module CmdText
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
    return unless all_guesses != ''

    secret_word.include?(player.guess) ? encourage : lose_health_message
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
end
