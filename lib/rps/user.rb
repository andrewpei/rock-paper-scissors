
class RPS::User
  attr_reader :user_id, :user_name, :password, :matches_won, :matches_lost

  def initialize(uid, user_name, password, matches_won=0, matches_lost=0)
    @user_id = uid
    @user_name = user_name
    @password = password
    @matches_won = matches_won
    @matches_lost = matches_lost
  end

end
