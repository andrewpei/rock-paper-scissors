
class RPS::Game

  attr_reader :player_1, :player_2
  attr_accessor :winning_move, :play_count

  def initialize(player_1_id, player_2_id)
    @player_1_id = player_1_id
    @player_2_id = player_2_id
    @winning_move = nil
  end

  def self.create_game(player_1_id, player_2_id)
    RPS.orm.create_game(player_1_id, player_2_id)
  end

  def self.player_move(player_id, game_id, move)
    result = RPS.orm.send_move(player_id, game_id, move)
    #=> result = {"p1_move"=>"rock", "p2_move"=>"paper", "p1_score"=>1, "p2_score"=>1}
    if result["p1_move"] != nil && result["p2_move"] != nil
      self.play_round(result["p1_move"], result["p2_move"])
    end
  end

  def self.play_round(player_1_move, player_2_move)
    rules = {
      :rock     => { :rock => :draw, :paper => :paper, :scissors => :rock },
      :paper    => { :rock => :paper, :paper => :draw, :scissors => :scissors },
      :scissors => { :rock => :rock, :paper => :scissors, :scissors => :draw }
    }

    # wait for both players to send their move

    @winning_move = rules[player_1_move][player_2_move]
    if @winning_move == :draw
      # puts "It was a draw!"
      return :draw
    elsif @winning_move == player_1_move
      # puts "#{player_1} wins!"
      @winners[player_1] += 1
      # send ORM move + winner id
      return player_1
    elsif @winning_move == player_2_move
      # puts "#{player_2} wins!"
      @winners[player_2] += 1
      return player_2
    end
  end

  RPS.orm.set_round_outcome(winner_id, p1_score, p2_score)
end

# class RPSPlayer

#   def self.start

#     puts "Player 1, please enter your name."
#     player_1 = gets.chomp
#     puts "Player 2, please enter your name."
#     player_2 = gets.chomp

#     # create game
#     @game = RPS.new(player_1, player_2)

#     while @game.winners[player_1] < 2 && @game.winners[player_2] < 2
#       # puts "New game beginning!"

#       # send move to ORM
#       puts "#{player_1}, please enter your move: Rock, Paper, or Scissors."
#       player_1_move = STDIN.noecho(&:gets).chomp.to_sym

#       # send move to ORM
#       puts "#{player_2}, please enter your move: Rock, Paper, or Scissors."
#       player_2_move = STDIN.noecho(&:gets).chomp.to_sym

#       @game.play(player_1_move, player_2_move)

#       # send winner to ORM (round winner) -- no longer 2 moves -- asynchronous
#       @announce_outcome

#     end

#     puts "Game over."
#     @game.winning_move = nil
#   end

#   def announce_outcome(winner)
#     if winner == player_1 || winner == player_2
#       puts "#{winner} wins!"
#     else
#       puts "It was a draw!"
#     end
#   end

# end
