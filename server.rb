require 'sinatra'
require_relative 'lib/rps.rb'
require 'pry-byebug'

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
  if result[:success?]
    session[:user_id] = result[:user].user_id
    session[:user_name] = result[:user].user_name
    redirect 'dashboard'
  else
    @error = result[:error]
    erb :login #stay on page append error in red 
  end
  puts params
  erb :login
end

get '/register' do
  puts params
  erb :register
end

post '/register' do
  # binding.pry
  new_user = RPS::RegisterUser.run({
    user_name: params[:user_name],
    password: params[:password]
  })

  if new_user[:success?]
    session[:user_id] = new_user[:user].user_id
    session[:user_name] = new_user[:user].user_name
    redirect '/dashboard'
  else
    @error = new_user[:error]
    erb :register
  end

  puts params
  erb :register
end

get '/dashboard' do
  user_info = {:user_id => session[:user_id], :user_name => session[:user_name]}
  dashboard_data = RPS::RetrieveDashboardData.run(user_info)
  # binding.pry
  @eligible_opponents = dashboard_data[0]
  @user_info = dashboard_data[1]
  @all_matches = dashboard_data[2]
  binding.pry
  erb :dashboard
end

post '/dashboard' do
  # eligible_opponents = dashboard_data[0]
  # user_info = dashboard_data[1]
  # all_matches = dashboard_data[2]
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
