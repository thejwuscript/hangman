# frozen_string_literal: true

module Display

  def empty_lines
    secret_word.gsub(/[a-z]/, ' _')
  end

  def show_interface
    puts <<-HEREDOC

          Health left: #{health}

          Word: #{empty_lines}     #{secret_word}

          Misses: #{wrong_guesses}

    HEREDOC
  end
end
