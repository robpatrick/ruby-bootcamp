require 'sinatra'

class App < Sinatra::Base

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == 'admin' and password == 'admin'
  end

  get '/' do
    'hello'
  end
  get '/phrase' do
    'In the kingdom of boredom I wear the royal sweatpants.'
  end
end