require 'rubygems'
require_relative '../rps.rb'

describe "Rock Paper Scissors game" do

  it "Picks the right winner of the round when a the user input moves" do
    game = RPS.new("Andrew","Shehzan")
    result = game.pick_winner("rock", "scissors")
    expect(result).to eq("Andrew")
  end

  it "increments the score correctly when a winner is chosen" do
    game = RPS.new("Andrew","Shehzan")
    result = game.pick_winner("rock", "scissors")
    expect(game.player1score).to eq(1)
  end

  it "ends the game with the right winner when the game should be over" do
    game = RPS.new("Andrew","Shehzan")
    game.pick_winner("rock","rock")
    game.pick_winner("rock","paper")
    game.pick_winner("rock","scissors")
    game.pick_winner("paper","rock")
    result = game.check_if_over

    expect(result).to eq("Andrew")

  end

end
