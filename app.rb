require 'sinatra'

set :bind, '0.0.0.0'

get '/translate' do
  puts params

end

post '/translate' do
  puts params
end

