class RPS::RetrieveDashboardData
  def self.run(input)
    # binding.pry
    eligible_opponents = RPS.orm.retrieve_eligible_opponents(input[:user_id])
    user_info = RPS.orm.retrieve_user_info(input[:user_name])
    all_matches = RPS.orm.retrieve_user_match_history(input[:user_id])

    all_matches.each { |match|
      # binding.pry
      match.player1_id.to_i == input[:user_id].to_i ? opponent_id = match.player2_id.to_i : opponent_id = match.player1_id.to_i
      user_name = RPS.orm.retrieve_username(opponent_id)['user_name']
      match.display_opponent = user_name
    }
    # binding.pry
    return [eligible_opponents, user_info, all_matches]
  end
end

class RPS::StartNewGame
  def self.run(input)
    new_game = RPS.orm.create_game(input[:user_id], input[:opponent_id])
   
    return new_game
  end
end

class RPS::ContinueGame
  def self.run(input)
   
  end
end