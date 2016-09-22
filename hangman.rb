class Hangman
  attr_reader :difficulty_level, :guesses, :random_word, :guess_count

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
    @user_progress = 0
    @guess_count = 0
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

  # def show_word_as_blanks
  #   word_as_blanks = @random_word.gsub(/[a-z]/, " _ ")
  # end

  def get_random_word_length
    @random_word.length
  end

  def make_word_blanks
    word_array = @random_word.scan(/./)
    make_blanks = "_" * @random_word.length
    blanks_in_array = make_blanks.scan(/./)
    display_blanks = blanks_in_array.join("")
  end

  def get_user_guess(word_array, display_blanks)
    make_word_blanks

    loop do
      @user_guess = gets.chomp.downcase
      if display_blanks.include?("_") == false
        puts "You win!"
        exit
      elsif is_invalid_guess?
        puts "You can't do that. Try typing one letter at a time."
        print ' > '
      elsif is_guess_a_duplicate?
        puts "No duplicate letters, please."
        break
      elsif is_guess_in_word?
        @guesses << @user_guess
        is_guess_in_word?
        blanks_and_letters(word_array, display_blanks)
        break
      else
        @guess_count += 1
        puts "You're on guess ##{@guess_count} of 8."
      end
    end
  end

  def is_invalid_guess?
    @user_guess.length > 1 || @user_guess.empty? || @user_guess[/[a-z]+/] != @user_guess
  end

  def is_guess_in_word?
    @random_word.include? @user_guess
  end

  def is_guess_a_duplicate?
    @guesses.include?(@user_guess)
  end

  def blanks_and_letters(word_array, display_blanks)
    make_word_blanks

    if @guesses.length == 0
      show_blanks = blanks_in_array.join(" ")
      puts "#{show_blanks}"

    # elsif blanks_in_array.include?("_") == false
    #   puts "You win!"
    #   exit

    else
      word_array.each do |letter|
        letter_index = word_array.index(letter)
      end

      @guesses.each do |character|
        word_array.each_with_index do |item, index|
          if character == item
            blanks_in_array[index] = character
          end
        end
      end

      blanks_and_letters = blanks_in_array.join(" ")
      puts "#{blanks_and_letters}"

    end
  end

end
