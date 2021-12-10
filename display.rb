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
    puts <<-HEREDOC

          Health left: #{health}

          Word: #{letters}     

          Misses: #{display_wrong_guesses}

    HEREDOC
  end
end
