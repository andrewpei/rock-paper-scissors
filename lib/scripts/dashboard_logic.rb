class RPS::RetrieveDashboardData
  def self.run
    eligible_opponents = RPS.orm.retrieve_other_users(session[:user_id])
    user_info = RPS.orm.retrieve_user_info(session[:user_name])
    all_matches = RPS.orm.retrieve_user_match_history(session[:user_id])

    return [eligible_opponents, user_info, all_matches]
  end
end

class RPS::StartNewGame
  def self.run(input)
    new_game = RPS.orm.create_game(session[:user_id], input[:opponent_id])
    #Need to make sure and filter the dashboard data of users to ONLY eligible opponents
    return new_game
  end
end

class RPS::ContinueGame
  def self.run(input)
    #Is this method really needed? It could just pass the match_id to the game page which then retrieves round data
    #Need an ORM method to retrieve the Game object given a match_id
  end
end