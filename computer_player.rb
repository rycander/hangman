class ComputerPlayer
  def initialize(dict_filename = 'dictionary.txt')
    @dictionary = File.readlines(dict_filename).map(&:chomp)
  end

  def get_word_length
    set_word unless @word
    @word.length
  end

  def check_letter(letter)
    indices = []
    @word.each_char.with_index do |char, i|
      indices << i if char == letter
    end
    indices
  end

  def guess_letter(revealed_word, guessed_letters)
    correct_letters = revealed_word.split('').uniq - ["."]
    incorrect_letters = guessed_letters - correct_letters

    possible_words = @dictionary.select do |word|
      (word.split('') & incorrect_letters).empty? && matches_revealed = /^#{revealed_word}$/ =~ word
    end

    possible_words = @dictionary if possible_words == nil
    choose_most_frequent(possible_words.join('').split('') - guessed_letters)

  end

  private

  def choose_most_frequent(array)
    hash = Hash.new {|h, k| h[k] = 0}
    array.each {|el| hash[el] += 1}
    
    most_frequent = nil

    hash.each do |el|
      if most_frequent == nil || hash[most_frequent] < el[1]
        most_frequent = el[0] 
      end
    end
    most_frequent
  end

  def set_word
    @word = @dictionary.sample
  end

end
