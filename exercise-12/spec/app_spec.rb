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

  it 'expect an invalid page to return a page not found' do
    get '/hats.fb'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to eq('Page not found.')
  end

  it 'expect the home page to return translated content' do
    stub_translate_service('>Chaussettes<')
    get '/homepage.fr'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Chaussettes')
  end

  it 'expect the home page to return translated content when entered with mixed case' do
    stub_translate_service('>Chaussettes<')
    get '/hOmePagE.fr'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Chaussettes')
  end

  it 'expect the about page to return translated content' do
    stub_translate_service('>Chaussettes<')
    get '/about.fr'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Chaussettes')
  end

  it 'expect the about page to return translated content when entered with mixed case' do
    stub_translate_service('>Chaussettes<')
    get '/AbOuT.fr'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Chaussettes')
  end
end
