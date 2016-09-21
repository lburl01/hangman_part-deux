class Hangman
  attr_reader :difficulty_level, :guesses, :random_word

  def initialize
    @difficulty_level = {
      "easy" => [4, 6],
      "normal" => [6, 8],
      "hard" => [8, 99]
    }
    @word_length_min = 0
    @word_length_max = 0
    @random_word = 0
    @user_guess = 0
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
    @random_word = get_difficulty_words.sample.downcase
  end

  def show_word_as_blanks
    @random_word.each_char { |x| print "_ " }
  end

  def get_random_word_length
    @random_word.length
  end

  def get_user_guess
    loop do
      @user_guess = gets.chomp.downcase
      if is_invalid_guess?
        puts "You can't do that. Try typing one letter at a time."
        print ' > '
      elsif is_guess_a_duplicate?
        puts "No duplicate letters, please. Be original."
        break
      else
        @guesses << @user_guess
        puts "GUESSES: #{@guesses}"
        break
      end
    end
  end

  def is_invalid_guess?
    @user_guess.length > 1 || @user_guess.empty? || @user_guess[/[a-z]+/] != @user_guess
  end

  def is_guess_in_word?
    @random_word.include? @guesses[-1]
  end

  def is_guess_a_duplicate?
    @guesses.include?(@user_guess)
  end

end
