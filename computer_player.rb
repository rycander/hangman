class ComputerPlayer
  def initialize(dict_filename = 'dictionary.txt')
    @dictionary = File.readlines(dict_filename).map(&:chomp)
  end
end