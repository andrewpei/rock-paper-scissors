require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  puts params
  erb :login
end

post '/' do
  puts params
  erb :login
end

get '/register' do
  puts params
  erb :register
end

post '/register' do
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
