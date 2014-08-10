require './human_player.rb'
require './computer_player.rb'

class Game
  def initialize (guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @word = ""
    @missed_guesses = 0
    @guessed_letters = []
  end

  def run
    create_display_word
    turn_loop
    display_winner 
  end

  private

  def create_display_word
    length = @checking_player.get_word_length
    @word = ""
    length.times {@word.concat(".")}
  end

  def turn_loop
    until won?

      puts "#{@word}\nGuesses:#{@guessed_letters.sort}"
      @guessed_letters << @guessing_player.guess_letter(@word, @guessed_letters)

      insertion_points = @checking_player.check_letter(@guessed_letters.last)
      @missed_guesses += 1 unless insertion_points
      insertion_points.each do |i|
        @word[i] = @guessed_letters.last
      end
    end
  end

  def won?
    return true if @missed_guesses > 5
    return true unless @word.include?(".")
    false
  end

  def display_winner
    if @word.include?("_")
      puts "Checking player wins!"
    else
      puts "Guessing player wins!"
    end
  end
end

if $PROGRAM_NAME == __FILE__
  hp = HumanPlayer.new
  cp = ComputerPlayer.new('dictionary.txt')
  g = Game.new(cp, hp)
  g.run
end
