class HumanPlayer
  def initialize
  end

  def get_word_length
    puts "Think of a word.  How many letters long is it?"
    gets.to_i
  end

  def check_letter(letter)
    puts "Is #{letter} in your word?"
    locations = []
    while gets.downcase.include?('y')
      puts "List the location the letter appears in: (ex: 1 2 3)"
      locations.concat gets.chomp.split.map {|string| string.to_i-1}
      puts "Are there any more locations that #{letter} appears in?"
    end
    locations
  end

  def guess_letter(word, guessed_letters)
    @word = word
    @guessed_letters = guessed_letters

    puts "What letter do you want to guess?"
    
    guess = ""
    begin
      guess = gets.chomp.downcase
    end until valid_guess?(guess)
    guess
  end

  private

  def valid_guess?(guess)
    valid_guesses = ('a'..'z').to_a - @guessed_letters
    return true if valid_guesses.include? guess
    puts "Please enter a single letter that you have not guessed yet."
    false
  end
end
