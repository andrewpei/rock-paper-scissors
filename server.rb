require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  puts params
  erb :login

end

post '/' do
  puts params
  erb :game
end
