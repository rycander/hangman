require './human_player.rb'
require './computer_player.rb'

class Game
  def initialize (guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @word = ""
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
      @guessed_letters << @guessing_player.guess_letter(@guessed_letters, @word)

      insertion_points = @checking_player.check_letter(guessed_letters.last)
      insertion_points.each do |i|
        @word[i] = @guessed_letters.last
      end
    end
  end

  def won?
    return true if @guessed_letters.length > 10
    return true unless @word.include?("_")
    false
  end

  def display_winner
    if @word.include?("_")
      puts "Guessing player wins!"
    else
      puts "Checking player wins!"
    end
  end
end

if $PROGRAM_NAME == __FILE__
  hp = HumanPlayer.new
  cp = ComputerPlayer.new('dictionary.txt')
  g = Game.new(hp, cp)
  g.run
end