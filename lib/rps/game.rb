class RPS::Game
  attr_reader :player1_id, :player2_id, :match_id

  def initialize(match_id, player1_id, player2_id, p1_score=0, p2_score=0, game_over=false)
    @player1_id = player1_id
    @player2_id = player2_id
    @match_id = match_id
    @game_over = game_over
    @p1_score = p1_score
    @p2_score = p2_score
  end
end