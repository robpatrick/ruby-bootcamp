require 'sinatra'
require 'json'

class BillService < Sinatra::Base

  get '/bill' do
    JSON.parse(File.read(Dir.glob('**/bill.json').first)).to_s
  end

end