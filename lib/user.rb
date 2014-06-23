class RPS::User
  attr_reader :name, :user_id, :games_won, :games_lost

  def initialize(uid, name, password)
    @user_id = uid
    @name = name
    @password = password
    @games_won = 0
    @games_lost = 0
  end

end
