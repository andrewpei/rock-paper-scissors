require 'spec_helper'

describe RPS do
  let(:game) {RPS.new("Bob", "Joe")}

  describe "Initialize RPS game" do
    it "is an RPS game" do
      expect(game).to be_a(RPS)
    end

    xit "accepts arguments for two names" do
      expect(game.player_1).to eq("Bob")
      expect(game.player_2).to eq("Joe")
    end
  end

  describe "RPS play #method" do

    context "when p1/Bob wins" do
      xit "returns winning move if p1 wins" do
        res = game.play(:paper, :rock)
        expect(res).to eq()
        expect(game.winning_move).to eq(:paper)
      end
    end

    context "when p2/Joe wins" do
      xit "returns 'Joe wins!'" do
        game.play(:rock, :paper)
        expect(game.winning_move).to eq(:paper)
      end
    end

    context "when there is a draw" do
      xit "returns 'It was a draw!'" do
        game.play(:paper, :paper)
        expect(game.winning_move).to eq(:draw)
      end
    end

    # it "ends after a player wins 2 of 3 games" do
    # end
    # it "returns 'The game is over' if you try to play again"
  end

end







# describe "Rock Paper Scissors game" do

#   it "Picks the right winner of the round when a the user input moves" do
#     game = RPS.new("Andrew","Shehzan")
#     result = game.pick_winner("rock", "scissors")
#     expect(result).to eq("Andrew")
#   end

#   it "increments the score correctly when a winner is chosen" do
#     game = RPS.new("Andrew","Shehzan")
#     result = game.pick_winner("rock", "scissors")
#     expect(game.player1score).to eq(1)
#   end

#   it "ends the game with the right winner when the game should be over" do
#     game = RPS.new("Andrew","Shehzan")
#     game.pick_winner("rock","rock")
#     game.pick_winner("rock","paper")
#     game.pick_winner("rock","scissors")
#     game.pick_winner("paper","rock")
#     result = game.check_if_over

#     expect(result).to eq("Andrew")

#   end

# end
