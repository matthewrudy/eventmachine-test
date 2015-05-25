require 'sinatra'
require 'faraday'
require 'net/http'

set :port, '4567'

get '/net_http' do
  uri = URI.parse('http://localhost:1337/sleep')
  Net::HTTP.start(uri.host, uri.port) do |client|
    req = Net::HTTP::Get.new(uri.request_uri)
    client.request(req).body
  end
end

get '/em_synchrony' do
  request = EM::HttpRequest.new('http://localhost:1337/sleep').get
  response = EM::Synchrony.sync(request)
  response.response
end

get '/faraday' do
  conn = Faraday.new(:url => 'http://localhost:1337') do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end

  response = conn.get '/sleep'
  response.body
end

get '/faraday_em' do
  conn = Faraday.new(:url => 'http://localhost:1337') do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  :em_synchrony            # with em-synchrony
  end

  response = conn.get '/sleep'
  response.body
end
