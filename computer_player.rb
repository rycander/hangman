class ComputerPlayer
  def initialize(dict_filename = 'dictionary.txt')
    @dictionary = File.readlines(dict_filename).map(&:chomp)
  end

  def get_word_length
    4
  end

  def check_letter(letter)
    [1]
  end

  def guess_letter(word, guessed_letters)
    'a'
  end

end
