require './human_player.rb'
require './computer_player.rb'

class Game
  def initialize (options)
    @guessing_player = options[:guesser]
    @checking_player = options[:checker]
    @word = ""
    @missed_guesses = 0 
    @guessed_letters = []
  end

  def self.choose_rolls
    puts "Do you want to guess the word, or check it?"
    while true
      input = gets.chomp.downcase.to_sym

      if input == :guess
        return {
          guesser: HumanPlayer.new,
          checker: ComputerPlayer.new('dictionary.txt')
        }
      elsif input == :check
        return {
          checker: HumanPlayer.new,
          guesser: ComputerPlayer.new('dictionary.txt')
        }
      else
        puts "Please enter either guess or check."
      end

    end
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
  g = Game.new(Game.choose_rolls)
  g.run
end
