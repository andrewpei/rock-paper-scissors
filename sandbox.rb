class RPS

  @player1 = "ANDREW"
  @player2 = "Shehzan"

  def play(move1,move2)
    outcomes = {
      "rock"     => {"rock" => :draw, "paper" => @player2, "scissors" => @player1},
      "paper"    => {"rock"=> @player1, "paper"  => :draw, "scissors" => @player2},
      "scissors" => {"rock"=> @player2, "paper"  => @player1, "scissors" => :draw}
    }

    winner = outcomes[move1][move2]

  end
end

game = RPS.new
game.play("rock", "paper")