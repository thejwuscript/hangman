# frozen_string_literal: true

class Game
  attr_accessor :health, :wrong_letters, :secret_word

  def initialize
    @health = '♥♥♥♥♥♥'
    @wrong_letters = ''
    @secret_word = ''
  end

  def play
    prep_game
  end

  def prep_game
    select_secret_word
    show_UI
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

  def show_UI
    <<-HEREDOC

    Health left: #{health}"

          Word: #{player_guess}

          Misses: #{wrong_letters}

    HEREDOC
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
# show 🍰🍰🍰🍰🍰🍰
# Show "Misses: "

# wordlist = File.open('5desk.txt', 'r') { |file| file.readlines }
# secret_word = ""
# loop do
#   candidate = wordlist.sample
#   if candidate.length >= 7 && candidate.length <= 14
#     secret_word = candidate[0..-3].downcase
#     break
#   end
# end
# p secret_word

# ♥♥

# ♥♥
