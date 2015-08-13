require 'rspec'
require 'json'

describe App do
  include Rack::Test::Methods

  RESULT = JSON.parse(File.read(Dir.glob('**/bill.json').first)).to_s

  def app
    App.new
  end

  describe '/authenticate' do
    it 'expect invalid credentials (email) to receive a 401 (unauthorized)' do
      post '/authenticate', :email => 'admin@spoon.com', :password => 'admin'
      expect(last_response.status).to eq(401)
      expect(last_response.body).to include('Please try to log in again')
    end

    it 'expect invalid credentials (password) to receive a 401 (unauthorized)' do
      post '/authenticate', :email => 'admin@thing.com', :password => 'password'
      expect(last_response.status).to eq(401)
      expect(last_response.body).to include('Please try to log in again')
    end

    it 'expect valid credentials to receive a 200 (ok)' do
      stub_request(:get, /.*bill.*/).to_return(:status => 200, :body => RESULT)
      post '/authenticate', :email => 'admin@thing.com', :password => 'admin'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('Bill Viewer')
    end
  end

  describe '/login' do
    it 'expect login to render the login form' do
      get '/login'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('email')
      expect(last_response.body).to include('password')
    end
  end


end

describe App do
  subject do
    app = described_class.allocate
    app.send :initialize
    app
  end

  describe '#fetch_bill' do
    it 'expects to read the json content from resources' do
      stub_request(:get, /.*bill.*/).to_return(:status => 200, :body => RESULT)
      result = subject.send :fetch_bill
      expect(result.statement.generated).to eq('2015-01-11')
      expect(result.statement.due).to eq('2015-01-25')
      expect(result.statement.period.from).to eq('2015-01-26')
      expect(result.statement.period.to).to eq('2015-02-25')
      expect(result.package.subscriptions[0].type).to eq('tv')
      expect(result.package.subscriptions[0].name).to eq('Variety with Movies HD')
      expect(result.package.subscriptions[0].cost).to eq(50.00)
      expect(result.package.total).to eq(71.40)

      #   ETC
    end
  end

end





