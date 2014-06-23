require 'io/console'
class RPSPlayer

  def start
    keep_playing = true

    puts "Player 1 please enter your name"
    player1name = gets.chomp
    puts "Player 2 please enter your name"
    player2name = gets.chomp

    game = RPS.new(player1name,player2name)

    while (keep_playing)
      puts "#{player1name}'s move now"
      move1 = STDIN.noecho(&:gets).chomp

      puts "#{player2name}'s move now"
      move2 = STDIN.noecho(&:gets).chomp

      winner = game.pick_winner(move1,move2)
      (winner == :draw) ? (puts "The round was a draw") : (puts "#{winner} won this round!")
      puts "The score is now #{game.player1}: #{game.player1score}, #{game.player2}: #{game.player2score}"

      if game.check_if_over != false
        puts "#{game.check_if_over} has won the match!"
        keep_playing = false
      end

    end

  end
end


module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
  end
end
