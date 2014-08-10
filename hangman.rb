require './human_player.rb'
require './computer_player.rb'

class Game
  def initialize (guessing_player, checking_player)
  end
end

if $PROGRAM_NAME == __FILE__
  hp = HumanPlayer.new
  cp = ComputerPlayer.new('dictionary.txt')
  g = Game.new(hp, cp)
end