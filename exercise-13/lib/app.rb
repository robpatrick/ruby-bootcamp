require 'sinatra'
require 'json'
require 'recursive-open-struct'
require 'faraday'
#
# Main Application class for exercise-13
#
class App < Sinatra::Base

  get '/login' do
    slim :login
  end

  post '/authenticate' do
    if params['email'] &&
       params['password'] &&
       params['email'] == 'admin@thing.com' &&
       params['password'] == 'admin'
      slim :bill, locals: { bill: fetch_bill }
    else
      status 401
      slim :unauthorised
    end
  end

  private

  def fetch_bill
    response = Faraday.get 'http://localhost:9393/bill'
    RecursiveOpenStruct.new(eval(response.body), :recurse_over_arrays => true ) if response.status == 200
  end

end