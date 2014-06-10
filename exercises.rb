# For each exercise try and guess the computational complexity
require 'pry-debugger'
require 'rubygems'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    str == 'wishes' ? "nope" : str * 3
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO

    count = 0
    array.each {|element| 
      count += 1
    }
    return count
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    if array.size < 2
      return nil
    end
    return array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    array.reduce(:+)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    # TODO
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    # TODO
    array.each {|element| 
      puts element
    }
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    if array[-1] == 'panda' 
      array[-1] = 'GODZILLA'
    else 
      array[-1] = 'panda'
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    array.each { |element|
      if element == str
        array << str
        break
      end
    }
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each {|name, occupation| 
      puts "#{name}: #{occupation}"
    }
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    year = time.year
    if year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)
      return true
    end
      return false
  end
end


class RPS
  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.

  attr_reader :player1, :player2
  attr_accessor  :player1score, :player2score
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1score = 0
    @player2score = 0
    @keep_playing = true
  end

  def pick_winner(move1,move2)
    outcomes = {
      "rock"     => {"rock" => :draw, "paper" => @player2, "scissors" => @player1},
      "paper"    => {"rock"=> @player1, "paper"  => :draw, "scissors" => @player2},
      "scissors" => {"rock"=> @player2, "paper"  => @player1, "scissors" => :draw}
    }

    winner = outcomes[move1][move2]
    winner == @player1 ? @player1score += 1 : @player2score += 2

    return winner
  end

  def check_if_over
    if @player1score == 2
      return @player1
    elsif @player2score == 2
      return @player2
    else
      return false
    end
  end

end


require 'io/console'
class RPSPlayer

  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again.
  def start


    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)

    # invalid_input1, invalid_input2  = true
    # options = ['rock', 'paper', 'scissors']
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