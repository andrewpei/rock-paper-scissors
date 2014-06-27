require 'pry-byebug'

class RPS::RegisterUser
  def self.run(input)
    user = RPS.orm.retrieve_user_info(input[:user_name])
    if user.nil?
      new_user = RPS.orm.create_user(input[:user_name], input[:password])
      return {:success? => true, :user => new_user}
    end

    return {:success? => false, :error => "That user name is taken! Please try another"}
  end
end