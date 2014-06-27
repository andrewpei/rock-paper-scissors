class RPS::Game
  attr_reader :player1_id, :player2_id, :match_id, :game_status
  attr_accessor :display_opponent

  def initialize(match_id, player1_id, player2_id, p1_score=0, p2_score=0, game_status="ACTIVE")
    @player1_id = player1_id
    @player2_id = player2_id
    @match_id = match_id
    @game_status = game_status
    @p1_score = p1_score
    @p2_score = p2_score
  end
end

