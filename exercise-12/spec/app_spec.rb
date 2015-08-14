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

  it 'expect the home page with invalid extension to return untranslated page' do
    stub_request(:post, /.*datamarket.accesscontrol.windows.net.*/).
        to_return(:status => 200, :body => "{\"expires_in\":\"599\"}")
    stub_request(:get, /.*api.microsofttranslator.com.*/).
        to_return(:status => 500, :body => '')
    get '/homepage.xx'
    expect(last_response.body).to include('This is a line of text that should be translated into the language of your choice.')
  end
end
