require 'sinatra'

set :port, '1337'

get '/sleep' do
  sleep 1
  "slept"
end
