require 'sinatra'

enable :sessions

set :bind, '0.0.0.0'

get '/' do
  puts params
  erb :login
end

post '/' do
  result = RPS::UserSignIn.run({
    user_name: params[:user_name],
    password: params[:password]
  })

  if result.success?
    session[:user_id] = result.user_id
    session[:user_name] = result.user_name
    redirect back
  else
    @error = result[:error]
    erb :login_error
  end
  puts params
  erb :login
end

get '/register' do
  puts params
  erb :register
end

post '/register' do
  result = RPS::RegisterUser.run({
    user_name: params[:user_name],
    password: params[:password]
  })

  if result.success?
    session[:user_id] = result.user_id
    session[:user_name] = result.user_name
    redirect back
  else
    @error = result[:error]
    erb :register #What do we do when bad register attempt? Need to stay on page but throw message
  end

  puts params
  erb :register
end

get '/dashboard' do
  puts params
  erb :dashboard
end

post '/dashboard' do
  puts params
  erb :dashboard
end

get '/game' do
  puts params
  erb :game
end

post '/game' do
  puts params
  erb :game
end
