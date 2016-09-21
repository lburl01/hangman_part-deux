require_relative 'hangman.rb'

def main
  game = Hangman.new

  word_dictionary = game.get_all_words

  # loop do

    puts 'What difficulty level would you like to play?'
    print 'Type Easy, Normal, or Hard > '

    difficulty_level = game.get_difficulty_level

    random_word = game.get_random_word
    puts "#{random_word}"

    random_word_length = game.get_random_word_length
    puts "There are #{random_word_length} letters in your word. Get guessing!"

    3.times do
      puts 'What letter would you like to guess?'
      print ' > '

      user_guess = game.get_user_guess

      if game.is_guess_in_word? == true
        puts "Great guess!"
      else
        puts "Hmmm, not quite a match."
      end

    end

  # end
end

if __FILE__ == $PROGRAM_NAME
  main
end
