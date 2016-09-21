class Hangman
  attr_reader :difficulty_level, :guesses

  def initialize
    @difficulty_level = {
      "easy" => [4, 6],
      "normal" => [6, 8],
      "hard" => [8, 99]
    }
    @word_length_min = 0
    @word_length_max = 0
    @random_word = 0
    @guesses = []
  end

  def get_all_words
    File.new("/usr/share/dict/words", 'r').readlines.map(&:chomp)
  end

  def get_difficulty_level
    loop do
      user_difficulty_choice = gets.chomp.downcase
      if @difficulty_level.has_key? user_difficulty_choice
        @word_length_min = @difficulty_level[user_difficulty_choice][0]
        @word_length_max = @difficulty_level[user_difficulty_choice][1]
        break
      else
        puts 'Not a valid difficulty level. Try choosing easy, normal, or hard.'
        print ' > '
      end
    end
  end

  def get_difficulty_words
    get_all_words.select do |word|
      word.length >= @word_length_min && word.length <= @word_length_max
    end
  end

  def get_random_word
    @random_word = get_difficulty_words.sample
  end

  def get_random_word_length
    @random_word.length
  end

  def show_user_progress

  end

end
