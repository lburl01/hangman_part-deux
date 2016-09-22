require_relative 'hangman.rb'

def want_to_keep_playing?
  get_choice = gets.chomp.upcase
  if get_choice == "N"
    puts "Thanks for playing!"
    exit
  end
end

def main

  loop do

    game = Hangman.new

    word_dictionary = game.get_all_words

    puts 'What difficulty level would you like to play?'
    print 'Type Easy, Normal, or Hard > '

    difficulty_level = game.get_difficulty_level

    random_word = game.get_random_word
    puts "random word: #{random_word}"

    random_word_length = game.get_random_word_length
    puts "There are #{random_word_length} letters in your word. Get guessing!"

    8.times do
      puts 'What letter would you like to guess?'
      print ' > '

      user_guess = game.get_user_guess

      if game.is_guess_in_word?
        puts "Great guess!"
      # elsif game.is_guess_a_duplicate?
      #   puts "testing duplication error"
      else
        puts "Hmmm, not quite a match."
      end

    end

    puts "Looks like you ran out of guesses! Would you like to play again (Y or N)?"
    print " > "
    end_game_or_not = want_to_keep_playing?

  end
end

if __FILE__ == $PROGRAM_NAME
  main
end
