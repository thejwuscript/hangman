# frozen_string_literal: true

module Display
  def letters
    if correct_guesses == ''
      secret_word.gsub(/[a-z]/, ' _')
    else
      secret_word.gsub(/[^#{correct_guesses}]/, '_').gsub(/(.{1})/, ' \1')
    end
  end

  def display_wrong_guesses
    wrong_guesses.chomp(',')
  end


  def show_interface
    system('clear')
    puts <<-HEREDOC
              \e[41m\e[1m   \e[4mHANGMAN\e[24m   \e[22m\e[0m

          Health left: #{health}

          Word: #{letters}

          Misses: #{display_wrong_guesses}

    HEREDOC
  end
end
