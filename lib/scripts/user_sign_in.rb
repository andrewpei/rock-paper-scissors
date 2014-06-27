class RPS::UserSignIn
  def self.run(input)
    user = RPS.orm.retrieve_user_info(input[:user_name])
    if user.nil?
      return { :success? => false, :error => "No user found, please sign up!" }
    end

    check_password = user.authenticate(input[:password])
    if !check_password
      return { :success? => false, :error => "Password incorrect!" }
    end

    {:success? => true, :user => user}
  end
end
