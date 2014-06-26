
class RPS::UserSignIn
  def self.run(input)
    user = RPS.orm.retrieve_user_info(input[:user_name])
    # binding.pry
    if user.nil?
      return { :success? => false, :error => "User doesn't exist by that username" }
    end

    check_password = user.authenticate(input[:password])
    if !check_password
      return { :success? => false, :error => "User's password doesn't match the password in the database" }
    end

    { :success? => true, :user => user }
  end
end

