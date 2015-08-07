require_relative '../lib/app'
require 'rspec'
require 'rack/test'
require 'helpers'

describe 'Main Rack App' do
  include Rack::Test::Methods
  include Helpers

  def app
    RackApp.new
  end

  it "invalid page should return a page not found" do
    get '/hats.fb'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to eq('Page not found.')
  end

  it "home page should return the home page data" do
    stub_translate_service('>Chaussettes<')
    get '/homepage.fr'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Chaussettes')
  end

end
