require 'pry-byebug'
module RPS
  class Game
    attr_reader :player1_id, :player2_id, :match_id, :current_player_turn

    @@draw = 0

    def initialize(player1_id, player2_id, p1_score, p2_score, game_over)
      @player1_id = player1_id
      @player2_id = player2_id
      @match_id = RPS.orm.create_game(player1_id, player2_id)
      @game_over = false
      @p1_score = 0
      @p2_score = 0
    end

    def player_move(player_id, move)
      player_id == @player1_id ? current_player = 'p1_move' : current_player = 'p2_move'
      current_round = RPS.orm.send_move(current_player, move, @match_id)
      if !current_round["p1_move"].nil? && !current_round["p2_move"].nil?
        # binding.pry
        return play_round(current_round["p1_move"], current_round["p2_move"], @p1_score, @p2_score)
      else
        current_round = RPS.orm.retrieve_current_round(@match_id)
        @p1_score = current_round['p1_score'].to_i
        @p2_score = current_round['p2_score'].to_i
        # binding.pry
        return "Next player turn" #need to figure out what to return to site
      end
    end

    def play_round(player1_move, player2_move, player1_score, player2_score)
      @rules = {
          'rock'     => { 'rock' => @@draw, 'paper' => @player2_id, 'scissors' => @player1_id},
          'paper'    => { 'rock' => @player1_id, 'paper' => @@draw, 'scissors' => @player2_id},
          'scissors' => { 'rock' => @player2_id, 'paper' => @player1_id, 'scissors' => @@draw}
      }

      round_winner_id = @rules[player1_move][player2_move]
      
      if round_winner_id == @player1_id
        @p1_score += 1
      elsif round_winner_id == @player2_id
        @p2_score += 1
      end

      if @p1_score == 3
        match_winner_id = @player1_id
        match_loser_id = @player2_id
        @game_over = true
      elsif @p2_score == 3
        match_winner_id = @player2_id
        match_loser_id = @player1_id
        @game_over = true
      end

      RPS.orm.set_round_outcome(@match_id, round_winner_id, @p1_score, @p2_score)
      
      if @game_over
        return end_game(match_winner_id, match_loser_id, @p1_score, @p2_score)
      else
        array_rounds_played = RPS.orm.retrieve_all_rounds(@match_id)
        RPS.orm.new_round(@match_id)
        return array_rounds_played
      end
    end

    def end_game(match_winner_id, match_loser_id, player1_score, player2_score)
      match_history_row = RPS.orm.set_match_winner(@match_id, match_winner_id)
      return match_history_row #something that says the game is over
    end
  
  end
end