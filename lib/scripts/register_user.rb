class RPS::RegisterUserOrSignIn
  def self.run(input)
    user = RPS.orm.retrieve_user_info(input[:user_name])
    if !user.nil?
      #user already exists
      #call RPS::UserSignin
      new_user = RPS.orm.create_user(input[:user_name], input[:password])
      {:success? => true, :user => new_user}
    end

    check_password = user.authenticate(input[:password])
    if check_password
      return {:success? => true, :user => user}
    else
      return {:success? => false, :error => "That user name is taken! Please try another"}
    end

    
  end
end