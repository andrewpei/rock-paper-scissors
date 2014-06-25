
class RPS::User
  attr_reader :name, :user_id, :matches_won, :matches_lost

  def initialize(uid, name, password, matches_won=0, matches_lost=0)
    @user_id = uid
    @name = name
    @password = password
    @matches_won = matches_won
    @matches_lost = matches_lost
  end

end
